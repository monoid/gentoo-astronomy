# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Virtual Moon Atlas Pro."
HOMEPAGE="http://www.ap-i.net/avl/en/"
SRC_URI="mirror://sourceforge/$PN/vmapro5.tgz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND=""

src_install () {
	declare SCH=/opt/virtualmoon
	dodir ${SCH}
	cp -R bin/ "${D}${SCH}/bin"
	cp -R lib/ "${D}${SCH}/lib"
	cp -R share/ "${D}${SCH}/share"
        exeinto /usr/bin
        doexe ${FILESDIR}/atlun
        doexe ${FILESDIR}/datlun
        doexe ${FILESDIR}/photlun
}
