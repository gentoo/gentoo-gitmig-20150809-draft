# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-games/ggz-gtk-games-0.0.7.ebuild,v 1.2 2003/09/10 18:16:12 vapier Exp $

DESCRIPTION="These are the gtk versions of the games made by GGZ Gaming Zone"
HOMEPAGE="http://ggz.sourceforge.net/"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gtk gtk2"

DEPEND="=games-board/ggz-gtk-client-0.0.7
	|| (
		gtk2? ( =x11-libs/gtk+-2* )
		gtk? ( =x11-libs/gtk+-1* )
		=x11-libs/gtk+-2*
	)"

src_compile() {
	local myconf=""
	if [ `use gtk2` ] ; then
		myconf="--enable-gtk=gtk2"
	elif [ `use gtk` ] ; then
		myconf="--enable-gtk=gtk1"
	else
		myconf="--enable-gtk=gtk2"
	fi
	econf ${myconf} || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS QuickStart.GGZ README* TODO
}
