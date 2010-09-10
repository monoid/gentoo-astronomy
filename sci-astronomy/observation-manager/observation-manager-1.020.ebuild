# Copyright 2010 Ivan Boldyrev
#
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils java-pkg-2 java-ant-2

MY_PN="observationManager"

DESCRIPTION="Observation manager."
HOMEPAGE="http://observation.sourceforge.net/"
SRC_URI="mirror://sourceforge/observation/ObservationManager_src/${PV}/${MY_PN}${PV}-src.zip"
LICENSE="GPL"
IUSE="deepsky imaging skychart solarsystem variablestars"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# Dependencies: xalan xercesImpl.jar xml-apis.jar
DEPEND="app-arch/unzip
		>=virtual/jdk-1.4"
RDEPEND=">=virtual/jre-1.4"

S="${WORKDIR}/${MY_PN}/build"
EANT_BUILD_TARGET="build_all"

src_unpack () {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}"/build-xml.patch
}

src_compile () {
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
