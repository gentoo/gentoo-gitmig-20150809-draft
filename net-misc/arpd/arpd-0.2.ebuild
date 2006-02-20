# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/arpd/arpd-0.2.ebuild,v 1.14 2006/02/20 20:43:20 jokey Exp $

inherit eutils

DESCRIPTION="ARP reply daemon enables a single host to claim all unassigned addresses on a LAN for network monitoring or simulation"
HOMEPAGE="http://www.citi.umich.edu/u/provos/honeyd/"
SRC_URI="http://www.citi.umich.edu/u/provos/honeyd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 hppa ppc sparc x86"
IUSE=""

DEPEND=">=dev-libs/libdnet-1.4
	>=dev-libs/libevent-0.6
	net-libs/libpcap"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/arpd.c.patch || die "epatch failed"

	sed -i \
		-e 's|$withval/lib/libevent.a; then||' \
		-e 's|if test -f $withval/include/event.h -a -f|if test -f $withval/include/event.h -a -f $withval/lib/libevent.a; then|' \
		configure || die "sed failed"
}

src_compile() {
	econf --with-libdnet=/usr --with-libevent=/usr || die "configure failed"
	emake || die
}

src_install() {
	dosbin arpd || die
	doman arpd.8
}
