# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gweled/gweled-0.4.ebuild,v 1.1 2003/12/31 16:15:36 vapier Exp $

inherit flag-o-matic

DESCRIPTION="Bejeweled clone game"
HOMEPAGE="http://sebdelestaing.free.fr/gweled/"
SRC_URI="http://sebdelestaing.free.fr/gweled/Release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/librsvg-2
	>=gnome-base/libgnomeui-2"

src_compile() {
	filter-flags -fomit-frame-pointer
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS NEWS
}
