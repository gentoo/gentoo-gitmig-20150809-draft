# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mrouted/mrouted-3.9_beta3.ebuild,v 1.8 2004/11/06 16:06:39 pyrania Exp $

inherit eutils

MY_P=${P/_}+IOS12
DEB_PVER=3
DESCRIPTION="IP multicast routing daemon"
HOMEPAGE="http://freshmeat.net/projects/mrouted/?topic_id=87%2C150"
SRC_URI="ftp://ftp.research.att.com/dist/fenner/mrouted/${MY_P}.tar.gz
	http://debian/pool/non-free/m/mrouted/mrouted_${PV/_/-}-${DEB_PVER}.diff.gz"

LICENSE="Stanford"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/os-headers
	dev-util/yacc"
RDEPEND=""

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
	dobin mrouted || die
	doman mrouted.8

	insinto /etc ; doins mrouted.conf
	exeinto /etc/init.d ; newexe ${FILESDIR}/mrouted.rc mrouted
}
