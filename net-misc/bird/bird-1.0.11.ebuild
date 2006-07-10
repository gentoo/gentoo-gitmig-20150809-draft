# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bird/bird-1.0.11.ebuild,v 1.1 2006/07/10 09:20:42 chainsaw Exp $

inherit eutils

DESCRIPTION="A routing daemon implementing OSPF, RIP/v2, BGP for IPv4 and IPv6"
HOMEPAGE="http://bird.network.cz"
SRC_URI="ftp://bird.network.cz/pub/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ipv6only client"

DEPEND="sys-devel/flex
	sys-devel/bison
	sys-devel/m4
	client? ( sys-libs/ncurses sys-libs/readline )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-destdir.patch
	epatch ${FILESDIR}/${PV}-flex-args.patch
	epatch ${FILESDIR}/${PV}-nostrip.patch
}

src_compile() {
	econf \
		$(use_enable ipv6only ipv6) \
		$(use_enable client) || die "econf failed"
	make || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	newinitd ${FILESDIR}/initrd-${P} bird
}
