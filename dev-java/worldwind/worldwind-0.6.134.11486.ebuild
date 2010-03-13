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
IUSE=""
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

src_unpack () {
		   unpack ${A}
		   cd ${S}
		   epatch "${FILESDIR}/encoding-build.patch"
		   java-pkg_jar-from jogl
		   java-pkg_jar-from gluegen
}

src_install () {
			java-pkg_dojar worldwind.jar
}
