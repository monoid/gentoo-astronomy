# Copyright 2010 Ivan Boldyrev
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

MY_PN=skychart
MY_PV=$(replace_version_separator 4 -)
DESCRIPTION="Planetarium for amauter astronomers."
HOMEPAGE="http://www.ap-i.net/skychart/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${MY_PV}-linux.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""
RESTRICT="strip"
EMUL_VER=20091231

DEPEND=""
RDEPEND="
	amd64? ( >=app-emulation/emul-linux-x86-xlibs-${EMUL_VER}
			>=app-emulation/emul-linux-x86-baselibs-${EMUL_VER}
			>=app-emulation/emul-linux-x86-gtklibs-${EMUL_VER} )
	x86? ( >=x11-libs/gtk+-2.0 )"

INSTALLDIR="/opt/${MY_PN}"

src_install () {
	dodir "${INSTALLDIR}" || die "Creating dir failed."
	cp -dpR bin/ "${D}/${INSTALLDIR}/bin" || die "Copying bin failed."
	cp -dpR lib/ "${D}/${INSTALLDIR}/lib" || die "Copying lib failed."
	cp -dpR share/ "${D}/${INSTALLDIR}/share" || die "Copying share failed."

	dodir /usr/bin || die "Creating dir failed."
	exeinto /usr/bin
	for f in skychart cdcicon varobs varobs_lpv_bulletin; do
		newbin "${FILESDIR}/$f.sh" "$f"
	done
}
