# Copyright 2010 Ivan Boldyrev
#
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils java-pkg-2 java-ant-2

MY_PN="JSatTrak"

DESCRIPTION="Satellite Tracker by Shawn Gano"
HOMEPAGE="http://www.gano.name/shawn/JSatTrak/index.html"
SRC_URI="http://www.gano.name/shawn/${MY_PN}/src/${MY_PN}-${PV}-src.zip"
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
			 =dev-java/swingx-0.9.5
			 =dev-java/worldwind-0.6.134.11486"

DEPEND="app-arch/unzip
		>=virtual/jdk-1.6
		${COMMON_DEPS}"
RDEPEND=">=virtual/jre-1.6
		 ${COMMON_DEPS}"

S="${WORKDIR}/${MY_PN}-${PV}-src/${MY_PN}"

src_prepare () {
	local i
	epatch "${FILESDIR}/encoding-build-impl.patch"
	epatch "${FILESDIR}/project-properties.patch"
	rm -rf Required_Libraries/{Beanshell,Jama,Java_Media_Framework,JGoodies-Looks,JOGL,Netscape_JavaScript,Swing\ Layout\ Extensions,SwingX,worldwind,xstream}
	for i in bsh jama jgoodies-looks-2.0 jmf-bin jogl swing-layout-1 \
			 swingx-0.9 worldwind-0.6.134 xstream; do
		java-pkg_jar-from "$i"
	done
}

src_install () {
	java-pkg_dojar dist/JSatTrak.jar
	java-pkg_dojar Required_Libraries/substance/substance.jar
	java-pkg_dojar Required_Libraries/substance/substance-swingx.jar
	java-pkg_dojar Required_Libraries/JOGLUTILS/JOGLUTILS.jar
	ewarn
	ewarn "  jsattrak ebuild uses bundled binary substance.jar,"
	ewarn "  and and substance-swingx.jar, a BSD-licensed LAF theme"
	ewarn "  from https://substance.dev.java.net/"
	ewarn "  and JOGLUTILS.jar from https://joglutils.dev.java.net/"
	ewarn
	java-pkg_dolauncher "${MY_PN}" --main jsattrak.gui.JSatTrak
}
