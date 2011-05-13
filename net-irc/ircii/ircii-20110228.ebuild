# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircii/ircii-20110228.ebuild,v 1.1 2011/05/13 03:53:15 binki Exp $

EAPI=4

inherit eutils

DESCRIPTION="An IRC and ICB client that runs under most UNIX platforms"
SRC_URI="ftp://ircii.warped.com/pub/ircII/${P}.tar.bz2"
HOMEPAGE="http://www.eterna.com.au/ircii/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ipv6"

DEPEND="sys-libs/ncurses"
# This and irc-client both install /usr/bin/irc #247987
RDEPEND="${DEPEND}
	!!net-irc/irc-client"

src_prepare() {
	epatch "${FILESDIR}"/${P}-glibc.patch
}

src_configure() {
	econf $(use_enable ipv6)
}

src_install() {
	emake -j1 DESTDIR="${D}" install

	dodoc ChangeLog INSTALL NEWS README \
		doc/Copyright doc/crypto doc/VERSIONS doc/ctcp
}
