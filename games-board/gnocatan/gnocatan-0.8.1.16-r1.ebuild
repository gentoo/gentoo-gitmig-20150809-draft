# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnocatan/gnocatan-0.8.1.16-r1.ebuild,v 1.4 2004/04/03 01:03:49 mr_bones_ Exp $

inherit eutils gnome2

DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://gnocatan.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnocatan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

RDEPEND=">=gnome-base/libgnomeui-2.2*
	=dev-libs/glib-1.2*
	>=app-text/scrollkeeper-0.3*"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	cd ${S}/client/gtk
	epatch ${FILESDIR}/chat.diff
	epatch ${FILESDIR}/gmap.diff
	sed -i \
		-e '/\(GDK\|GTK\|GNOME\)_DISABLE_DEPRECATED/d' chat.c histogram.c \
			|| die "sed failed"
	cd ${S}/client/common
	epatch ${FILESDIR}/nothing.diff
	cd ${S}/server
	epatch ${FILESDIR}/servertrade.diff
}

src_compile() {
	export G2CONF="${G2CONF} `use_enable nls`"
	gnome2_src_compile
}

src_install() {
	DOCS="AUTHORS ChangeLog README"
	gnome2_src_install
}
