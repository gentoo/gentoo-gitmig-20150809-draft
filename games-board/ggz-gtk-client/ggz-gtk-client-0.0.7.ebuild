# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/ggz-gtk-client/ggz-gtk-client-0.0.7.ebuild,v 1.1 2003/09/10 17:46:27 vapier Exp $

DESCRIPTION="The gtk client for GGZ Gaming Zone"
HOMEPAGE="http://ggz.sourceforge.net/"
SRC_URI="mirror://sourceforge/ggz/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gtk2 gtk"

DEPEND="=dev-games/ggz-client-libs-0.0.7
	>=sys-apps/sed-4
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
	econf ${myconf} --disable-debug || die
	sed -i '/^SUBDIRS/s:po::' Makefile
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS QuickStart.GGZ README* TODO
}
