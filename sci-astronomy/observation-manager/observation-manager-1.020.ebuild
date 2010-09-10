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
# IUSE="deepsky imaging solarsystem variablestars"
IUSE=""
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

src_install () {
	mkdir -p "${D}/usr/share/${PN}/"
	cp -r ../help ../catalog ../schema "${D}/usr/share/${PN}/"
	java-pkg_dojar ../gen/${MY_PN}.jar
	java-pkg_dojar ../lib/observation.jar
	java-pkg_dojar ../lib/obsUtils.jar
	java-pkg_dolauncher ${MY_PN} --main de.lehmannet.om.ui.navigation.ObservationManager \
		--pkg_args "-Djava.library.path=/usr/share/${PN} -Djava.ext.dirs=/usr/share/${PN} instDir=/usr/share/${PN}/"
}
