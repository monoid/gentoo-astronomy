# Copyright 2010 Ivan Boldyrev
#
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="NASA WorldWind Java SDK"
HOMEPAGE="http://worldwind.arc.nasa.gov/java/"
SRC_URI="http://builds.worldwind.arc.nasa.gov/releases/${PN}-${PV}.zip"
LICENSE="NASAWorldWind"
IUSE="doc"
SLOT="0.6.134"
KEYWORDS="~amd64 ~x86"

COMMON_DEPS="dev-java/jogl dev-java/gluegen"

DEPEND="app-arch/unzip
		>=virtual/jdk-1.5
		${COMMON_DEPS}"
RDEPEND=">=virtual/jre-1.5
		 ${COMMON_DEPS}"

S="${WORKDIR}"
EANT_BUILD_TARGET="worldwind.jarfile"
EANT_DOC_TARGET="javadocs"

src_prepare () {
	epatch "${FILESDIR}/encoding-build.patch"
	epatch "${FILESDIR}/encoding-worldwind-build.patch"
	java-pkg_jar-from jogl
	java-pkg_jar-from gluegen
}

src_install () {
	java-pkg_dojar worldwind.jar
	dodoc worldwind-nosa-1.3.html
	use doc && java-pkg_dojavadoc doc
}
