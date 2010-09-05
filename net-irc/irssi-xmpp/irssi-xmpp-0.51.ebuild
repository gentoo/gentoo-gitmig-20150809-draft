# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/irssi-xmpp/irssi-xmpp-0.51.ebuild,v 1.1 2010/09/05 12:03:29 xarthisius Exp $

EAPI="2"

inherit eutils toolchain-funcs multilib

DESCRIPTION="An irssi plugin providing Jabber/XMPP support"
HOMEPAGE="http://cybione.org/~irssi-xmpp/"
SRC_URI="http://cybione.org/~${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-irc/irssi-0.8.13
	>=net-libs/loudmouth-1.2.0[debug]"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build_system.patch \
		"${FILESDIR}"/${P}-implicit_conversion.patch
	sed -e "s/{MAKE} doc-install/{MAKE}/" \
		-i Makefile || die #322355
}

src_compile() {
	emake PREFIX="/usr" CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" IRSSI_LIB="/usr/$(get_libdir)/irssi" install || die
	dodoc README NEWS TODO docs/* || die #322355
}
