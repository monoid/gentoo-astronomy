# Copyright 2010 Ivan Boldyrev
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="virtualmoon"
DESCRIPTION="Virtual Moon Atlas Pro"
HOMEPAGE="http://www.ap-i.net/avl/en/"
SRC_URI="mirror://sourceforge/${MY_PN}/virtualmoon-${PV}-linux.tar"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""

RESTRICT="strip"

RDEPEND="virtual/opengl
	 >=x11-libs/gtk+-2.0"

INSTALLDIR="/opt/${MY_PN}"

src_unpack () {
	cd "${WORKDIR}"
	unpack "virtualmoon-${PV}-linux.tar"
	unpack "./virtualmoon-data-${PV}-linux_all.tgz"
	if use amd64; then
		unpack "./virtualmoon-${PV}-linux_x86_64.tgz"
	else
		unpack "./virtualmoon-${PV}-linux_i386.tgz"
	fi
}

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
