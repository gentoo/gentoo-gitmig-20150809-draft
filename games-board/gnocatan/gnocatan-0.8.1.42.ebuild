# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnocatan/gnocatan-0.8.1.42.ebuild,v 1.1 2004/11/12 21:39:30 rizzo Exp $

inherit eutils gnome2 debug

DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://gnocatan.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnocatan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="nls debug X"

RDEPEND="dev-libs/glib
	dev-util/pkgconfig
	X? ( >=gnome-base/libgnomeui-2.6.1.1
		>=app-text/scrollkeeper-0.3* )"

src_compile() {
	export G2CONF="${G2CONF} `use_enable nls`"
	export G2CONF="${G2CONF} `use_enable debug`"

	if use X ; then
		gnome2_src_compile
	else
		einfo
		einfo "Only building console server"
		einfo

		econf ${G2CONF} || die "./configure failure"
		emake || die "emake failed"
	fi
}

src_install() {
	DOCS="AUTHORS ChangeLog README COPYING INSTALL TODO NEWS"
	if use X ; then
		gnome2_src_install
	else
		make DESTDIR=${D} install
		dodoc ${DOCS}
	fi
}
