# Copyright 2010 Ivan Boldyrev
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="virtualmoon"
DESCRIPTION="Virtual Moon Atlas Pro"
HOMEPAGE="http://www.ap-i.net/avl/en/"
SRC_URI="mirror://sourceforge/${MY_PN}/vmapro${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

RESTRICT="strip"
EMUL_VER=20091231

RDEPEND="virtual/opengl
	amd64? ( >=app-emulation/emul-linux-x86-baselibs-${EMUL_VER}
			>=app-emulation/emul-linux-x86-gtklibs-${EMUL_VER} )
	x86? ( >=x11-libs/gtk+-2.0 )"

INSTALLDIR="/opt/${MY_PN}"

src_install () {
	local installdir="/opt/${MY_PN}"
	dodir "${installdir}" || die "Creating dir failed."
	insinto "${installdir}"
	doins -r lib share || die "Copying files failed."
	exeinto "${installdir}/bin"
	doexe bin/* || die "Copying files failed."

	exeinto /usr/bin
	for f in atlun datlun photlun; do
		newbin "${FILESDIR}/${f}" "${f}" || die "newbin for ${f} failed."
	done
}
