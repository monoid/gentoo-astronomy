# Copyright 2010 Ivan Boldyrev
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

MY_PN="skychart"
MY_PV=$(replace_version_separator 4 -)
DESCRIPTION="Planetarium for amauter astronomers"
HOMEPAGE="http://www.ap-i.net/skychart/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${MY_PV}-linux.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

RESTRICT="strip"
EMUL_VER=20091231

RDEPEND="
	amd64? ( >=app-emulation/emul-linux-x86-baselibs-${EMUL_VER}
			>=app-emulation/emul-linux-x86-gtklibs-${EMUL_VER} )
	x86? ( >=x11-libs/gtk+-2.0 )"

src_install () {
	local installdir="/opt/${MY_PN}"

	dodir "${installdir}" || die "Creating dir failed."
	insinto "${installdir}"
	doins -r lib share || die "Copying files failed."
	exeinto "${installdir}/bin"
	doexe bin/* || die "Copying files failed."

	for f in skychart cdcicon varobs varobs_lpv_bulletin; do
		newbin "${FILESDIR}/${f}.sh" "${f}" || die "newbin for ${f} failed."
	done
}
