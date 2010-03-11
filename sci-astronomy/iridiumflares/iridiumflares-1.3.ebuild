# Copyright 2010 Ivan Boldyrev
#
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
inherit eutils java-pkg-2 java-ant-2

MY_PN="IridiumFlares"

DESCRIPTION="Iridium flares prediction software"
HOMEPAGE="http://iridiumflares.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src/${PV}/${MY_PN}-${PV}.src.zip"
LICENSE="GPL"
IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="app-arch/unzip
	>=virtual/jdk-1.4
	dev-java/sun-java3d-bin"
RDEPEND=">=virtual/jre-1.4
	dev-java/sun-java3d-bin"

S=${WORKDIR}

src_prepare () {
	cd "${S}"
	cp "${FILESDIR}"/build-${PV}.xml build.xml || die "Copying build.xml failed."
	rm -rf "${PN}/tests/"
	java-pkg_jar-from sun-java3d-bin vecmath.jar
}

src_install () {
	java-pkg_dojar internationalization.jar iridiumflares.jar resources.jar
	java-pkg_dolauncher "${MY_PN}" --main iridiumflares.Main
	dodoc Author Changelog Install
}
