# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Planetarium for amauter astronomers."
HOMEPAGE="http://www.ap-i.net/skychart/"
SRC_URI="mirror://sourceforge/$PN/skychart-3.0.1.6-1202-linux.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND=""

src_install () {
	declare SCH=/opt/skychart
	dodir ${SCH}
        dodir /usr/bin
	cp -R bin/ "${D}${SCH}/bin"
        cp -R lib/ "${D}${SCH}/lib"
	cp -R share/ "${D}${SCH}/share"
        exeinto /usr/bin
        doexe ${FILESDIR}/skychart
        doexe ${FILESDIR}/cdcicon
        doexe ${FILESDIR}/varobs
        doexe ${FILESDIR}/varobs_lpv_bulletin
}
