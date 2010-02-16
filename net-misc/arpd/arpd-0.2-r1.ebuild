# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/arpd/arpd-0.2-r1.ebuild,v 1.1 2010/02/16 21:08:15 jlec Exp $

EAPI="3"

inherit eutils

DESCRIPTION="ARP server which claims all unassigned addresses (for network monitoring or simulation)"
HOMEPAGE="http://www.citi.umich.edu/u/provos/honeyd/"
SRC_URI="http://www.citi.umich.edu/u/provos/honeyd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/libdnet-1.4
	>=dev-libs/libevent-0.6
	net-libs/libpcap
	!sys-apps/iproute2"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/arpd.c.patch
	epatch "${FILESDIR}"/${P}-libevent.patch

	sed -i \
		-e 's|$withval/lib/libevent.a; then||' \
		-e 's|if test -f $withval/include/event.h -a -f|if test -f $withval/include/event.h -a -f $withval/lib/libevent.a; then|' \
		configure || die "sed failed"
}

src_configure() {
	econf --with-libdnet="${EPREFIX}"/usr --with-libevent="${EPREFIX}"/usr
}

src_install() {
	dosbin arpd || die
	doman arpd.8 || die
}
