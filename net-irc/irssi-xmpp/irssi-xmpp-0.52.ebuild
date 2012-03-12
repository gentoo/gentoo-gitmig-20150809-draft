# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-xmpp/irssi-xmpp-0.52.ebuild,v 1.1 2012/03/12 13:24:27 xarthisius Exp $

EAPI=4

inherit toolchain-funcs multilib

DESCRIPTION="An irssi plugin providing Jabber/XMPP support"
HOMEPAGE="http://cybione.org/~irssi-xmpp/"
SRC_URI="http://cybione.org/~${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-irc/irssi
	net-libs/loudmouth"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -e "s/{MAKE} doc-install/{MAKE}/" \
		-i Makefile || die #322355
	sed -e "/^CFLAGS\|LDFLAGS/ s/=/+=/" \
		-i config.mk || die
}

src_compile() {
	emake PREFIX=/usr CC="$(tc-getCC)"
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr IRSSI_LIB=/usr/$(get_libdir)/irssi install
	dodoc README NEWS TODO docs/*
}
