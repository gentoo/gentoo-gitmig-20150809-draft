# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/arpd/arpd-0.2.ebuild,v 1.15 2008/11/27 20:47:06 vapier Exp $

inherit eutils

DESCRIPTION="ARP server which claims all unassigned addresses (for network monitoring or simulation)"
HOMEPAGE="http://www.citi.umich.edu/u/provos/honeyd/"
SRC_URI="http://www.citi.umich.edu/u/provos/honeyd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 hppa ppc sparc x86"
IUSE=""

DEPEND=">=dev-libs/libdnet-1.4
	>=dev-libs/libevent-0.6
	net-libs/libpcap
	!sys-apps/iproute2"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/arpd.c.patch

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
