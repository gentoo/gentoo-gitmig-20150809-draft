# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ircii/ircii-20040820.ebuild,v 1.4 2004/11/13 18:17:52 swegener Exp $

IUSE="ipv6"

DESCRIPTION="ircII is an IRC and ICB client that runs under most UNIX platforms."
SRC_URI="ftp://ircii.warped.com/pub/ircII/${P}.tar.bz2"
HOMEPAGE="http://www.eterna.com.au/ircii/"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~sparc ~ppc"

src_compile() {
	econf $(use_enable ipv6) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc ChangeLog INSTALL NEWS README \
		doc/Copyright doc/crypto doc/VERSIONS doc/ctcp \
		|| die "dodoc failed"
}
