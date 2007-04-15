# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-filter-userspace/l7-filter-userspace-0.4.ebuild,v 1.1 2007/04/15 10:30:43 dragonheart Exp $

inherit autotools

MY_P=${PN}-v${PV}
DESCRIPTION="Userspace utilities for layer 7 iptables QoS"
HOMEPAGE="http://l7-filter.sourceforge.net"
SRC_URI="mirror://sourceforge/l7-filter/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""
SLOT="0"
S="${WORKDIR}"/${MY_P}
DEPEND="
		net-libs/libnetfilter_conntrack
		net-libs/libnetfilter_queue"
RDEPEND="net-misc/l7-protocols
		${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	cp "${FILESDIR}"/configure.ac .
	cp "${FILESDIR}"/Makefile.am .
	epatch "${FILESDIR}"/${P}-misc.patch
	mv Changelog ChangeLog
	mv LICENSE COPYING
	touch AUTHORS INSTALL NEWS
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README TODO BUGS
}
