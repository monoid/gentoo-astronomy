# Copyright 2010 Ivan Boldyrev
#
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils java-pkg-2 java-ant-2

MY_PN="observationManager"

DESCRIPTION="Observation manager."
HOMEPAGE="http://observation.sourceforge.net/"
SRC_URI="mirror://sourceforge/observation/ObservationManager_src/${PV}/${MY_PN}${PV}-src.zip
		 mirror://sourceforge/observation/oal_JavaAPI/2.1/observation2.1-src.zip"
LICENSE="GPL MIT"
IUSE="deepsky imaging skychart solarsystem variablestars"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Dependencies: xalan xercesImpl.jar xml-apis.jar
DEPEND="app-arch/unzip
		>=virtual/jdk-1.5"
RDEPEND=">=virtual/jre-1.5"

S="${WORKDIR}/${MY_PN}/build"
S2="${WORKDIR}/observation/build"
EANT_BUILD_TARGET="build_all"

src_unpack () {
	unpack "${MY_PN}${PV}-src.zip"
	(cd "${S}"
		epatch "${FILESDIR}"/build-xml.patch
		rm ../lib/observation.jar
		rm ../lib/ext_*.jar
	)
	mkdir observation
	cd observation
	unpack observation2.1-src.zip
	mkdir lib
}

src_compile () {
	cd "${S2}"
	ant || die "obervation compilation failed"
	cp ../gen/observation.jar "${S}/../lib/" || die
	ant -f extensions/deepSky/build.xml || "deepSky compilation failed"
	cp ../gen/ext_DeepSky.jar "${S}/../lib/"
	ant -f extensions/imaging/build.xml || "imaging compilation failed"
	cp ../gen/ext_Imaging.jar "${S}/../lib/"
	ant -f extensions/solarSystem/build.xml || "solarSystem compilation failed"
	cp ../gen/ext_SolarSystem.jar "${S}/../lib/"
	ant -f extensions/variableStars/build.xml || "variableStars compilation failed"
	cp ../gen/ext_VariableStars.jar "${S}/../lib/"

	cd "${S}"
	ant "${EANT_BUILD_TARGET}" || die "Compilation failed"
	if use deepsky; then
		ant -buildfile extensions/deepSky/build.xml || die "deepSky compilation failed"
	fi
	if use imaging; then
		ant -buildfile extensions/imaging/build.xml || die "imaging compilation failed"
	fi
	if use skychart; then
		ant -buildfile extensions/skychart/build.xml || die "skychart compilation failed"
	fi
	if use solarsystem; then
		ant -buildfile extensions/solarSystem/build.xml || die "solarSystem compilation failed"
	fi
	if use variablestars; then
		ant -buildfile extensions/variableStars/build.xml || die "variableStars compilation failed"
	fi
}

src_install () {
	mkdir -p "${D}/usr/share/${PN}/"
	cp -r ../help ../catalog ../schema "${D}/usr/share/${PN}/"
	java-pkg_dojar ../gen/${MY_PN}.jar
	java-pkg_dojar ../lib/observation.jar
	java-pkg_dojar ../lib/obsUtils.jar
	if use deepsky; then
		java-pkg_dojar ../gen/obsMgr_ext_DeepSky.jar
		java-pkg_dojar ../lib/ext_DeepSky.jar
	fi
	if use imaging; then
		java-pkg_dojar ../gen/obsMgr_ext_Imaging.jar
		java-pkg_dojar ../lib/ext_Imaging.jar
	fi
	if use skychart; then
		java-pkg_dojar ../gen/obsMgr_ext_Skychart.jar
	fi
	if use solarsystem; then
		java-pkg_dojar ../gen/obsMgr_ext_SolarSystem.jar
		java-pkg_dojar ../lib/ext_SolarSystem.jar
	fi
	if use variablestars; then
		java-pkg_dojar ../gen/obsMgr_ext_VariableStars.jar
		java-pkg_dojar ../lib/ext_VariableStars.jar
	fi
	java-pkg_dolauncher ${MY_PN} --main de.lehmannet.om.ui.navigation.ObservationManager \
		--pkg_args "-Djava.library.path=/usr/share/${PN} -Djava.ext.dirs=/usr/share/${PN} instDir=/usr/share/${PN}/"
}
