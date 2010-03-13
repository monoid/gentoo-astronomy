# Copyright 2010 Ivan Boldyrev
#
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils java-pkg-2 java-ant-2

MY_PN="JSatTrak"

DESCRIPTION="Satellite Tracker by Shawn Gano."
HOMEPAGE="http://www.gano.name/shawn/JSatTrak/index.html"
SRC_URI="http://www.gano.name/shawn/JSatTrak/src/${MY_PN}-${PV}-src.zip"
LICENSE="LGPL-3"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

COMMON_DEPS="dev-java/jogl
			 dev-java/jama
			 dev-java/jmf-bin
			 dev-java/xstream
			 >=dev-java/jgoodies-looks-2
			 dev-java/swing-layout
			 =dev-java/worldwind-0.6.134.11486"

DEPEND="app-arch/unzip
		>=virtual/jdk-1.6
		${COMMON_DEPS}"
RDEPEND=">=virtual/jre-1.6
		 ${COMMON_DEPS}"

S="${WORKDIR}/${MY_PN}-${PV}-src/JSatTrak"

src_unpack () {
		   unpack ${A}
		   cd ${S}
		   epatch "${FILESDIR}/encoding-build-impl.patch"
		   java-pkg_jar-from jogl
		   java-pkg_jar-from jama
		   java-pkg_jar-from jmf-bin
		   java-pkg_jar-from xstream
		   java-pkg_jar-from bsh
		   java-pkg_jar-from jgoodies-looks-2.0
		   java-pkg_jar-from swing-layout-1
		   java-pkg_jar-from worldwind-0.6.134
}

src_install () {
			java-pkg_dojar dist/JSatTrak.jar
			java-pkg_dojar Required_Libraries/substance/substance.jar
# 			java-pkg_dojar Required_Libraries/worldwind/worldwind.jar
			ewarn
			ewarn "  jsattrak ebuild uses bundled binary substance.jar,"
			ewarn "  a BSD-licensed LAF theme from https://substance.dev.java.net/"
# 			ewarn "  Bundled NASA WorldWind Java SDK is also used until some bugs resoved."
			ewarn
			java-pkg_dolauncher ${MY_PN} --main jsattrak.gui.JSatTrak
}
