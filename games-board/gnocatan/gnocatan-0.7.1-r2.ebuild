# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/gnocatan/gnocatan-0.7.1-r2.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

DESCRIPTION="A clone of the popular board game The Settlers of Catan"
HOMEPAGE="http://gnocatan.sourceforge.net/"
SRC_URI="mirror://sourceforge/gnocatan/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1*
	=dev-libs/glib-1*
	gnome-base/gnome-libs
	>=sys-apps/sed-4
	gnome-base/ORBit"

src_unpack() {
	unpack ${A}
	sed -i -e "s/term1.dccs.com.au/gnocatan.debian.net/" ${S}/common/meta.h || \
		die "sed meta.h failed"
}

src_compile() {
	econf `use_enable nls` || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README
}
