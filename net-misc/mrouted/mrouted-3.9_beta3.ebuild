# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

MY_P=${P/_}+IOS12
DEB_PVER=3
DESCRIPTION="IP multicast routing daemon"
HOMEPAGE="http://freshmeat.net/projects/mrouted/?topic_id=87%2C150"
SRC_URI="ftp://ftp.research.att.com/dist/fenner/mrouted/${MY_P}.tar.gz
	http://ftp.debian.org/debian/pool/non-free/m/mrouted/mrouted_${PV/_/-}-${DEB_PVER}.diff.gz"

LICENSE="Stanford"
SLOT="0"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/os-headers"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/mrouted_${PV/_/-}-${DEB_PVER}.diff
	sed -i "s:-O:${CFLAGS}:" Makefile
}

src_compile() {
	emake || die
}

src_install() {
	dobin mrouted
	doman mrouted.8

	insinto /etc/conf.d
	newins ${S}/mrouted.conf

	exeinto /etc/init.d
	doexe ${FILESDIR}/mrouted
}
