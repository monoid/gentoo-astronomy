# Copyright 2012 Ivan Boldyrev
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit versionator

MY_PN="skychart"
MY_PV=$(replace_version_separator 2 -)
DESCRIPTION="Planetarium for amauter astronomers"
HOMEPAGE="http://www.ap-i.net/skychart/"
SRC_URI="
	x86? ( mirror://sourceforge/skychart/${MY_PN}-${MY_PV}-linux_i386.tar.bz2 )
	amd64? ( mirror://sourceforge/skychart/${MY_PN}-${MY_PV}-linux_x86_64.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

RESTRICT="strip"

RDEPEND=">=x11-libs/gtk+-2.0"

S="${WORKDIR}/${MY_PN}"

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
