# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnocatan/gnocatan-0.8.1.16-r1.ebuild,v 1.1 2004/02/24 16:38:41 rizzo Exp $

inherit gnome2

DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://gnocatan.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnocatan/${P}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="nls"

DEPEND=">=gnome-base/libgnomeui-2.2*
	=dev-libs/glib-1.2*
	>=app-text/scrollkeeper-0.3*"

G2CONF="${G2CONF} `use_enable nls`"
DOCS="AUTHORS ChangeLog README"

src_unpack() {
	unpack ${A}
	cd ${S}
	cd ${S}/client/gtk
	epatch ${FILESDIR}/chat.diff
	epatch ${FILESDIR}/gmap.diff
	cd ${S}/client/common
	epatch ${FILESDIR}/nothing.diff
	cd ${S}/server
	epatch ${FILESDIR}/servertrade.diff
}
