# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gweled/gweled-0.3.ebuild,v 1.1 2003/11/29 06:19:01 mr_bones_ Exp $

inherit games flag-o-matic

DESCRIPTION="Bejeweled clone game"
HOMEPAGE="http://sebdelestaing.free.fr/gweled/"
SRC_URI="http://sebdelestaing.free.fr/gweled/Release/${P}.tar.gz"

KEYWORDS="x86"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=x11-libs/gtk+-2
	>=gnome-base/librsvg-2
	>=gnome-base/libgnomeui-2"

src_compile() {
	filter-flags "-fomit-frame-pointer"
	# gnome libraries look for high scores in /var/lib/games...
	egamesconf --localstatedir="/var/lib" || die
	emake                                 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS NEWS          || die "dodoc failed"
	prepgamesdirs
}
