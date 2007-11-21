# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/microdc2/microdc2-0.15.6.ebuild,v 1.2 2007/11/21 15:46:00 armin76 Exp $

DESCRIPTION="A small command-line based Direct Connect client"
HOMEPAGE="http://corsair626.no-ip.org/microdc/"
SRC_URI="http://corsair626.no-ip.org/microdc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

DEPEND="dev-libs/libxml2
	sys-libs/ncurses
	>=sys-libs/readline-4
	nls? ( sys-devel/gettext )"

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README doc/*
}
