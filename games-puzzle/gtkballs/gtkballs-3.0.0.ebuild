# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gtkballs/gtkballs-3.0.0.ebuild,v 1.1 2003/09/10 06:36:00 vapier Exp $

DESCRIPTION="An entertaining game based on the old DOS game lines"
SRC_URI="http://gtkballs.antex.ru/dist/${P}.tar.gz"
HOMEPAGE="http://gtkballs.antex.ru/"

KEYWORDS="x86 ppc"
SLOT="3"
LICENSE="GPL-2"
IUSE="nls"

DEPEND="=x11-libs/gtk+-2*
	nls? ( >=sys-devel/gettext-0.10.38 ) "

src_compile() {
	local myconf
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"
	econf ${myconf}
	emake || die
}

src_install() {
	einstall
	dodoc ChangeLog AUTHORS COPYING INSTALL README* TODO NEWS ABOUT-NLS
}
