# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ermixer/ermixer-0.8.ebuild,v 1.16 2004/11/01 19:40:07 corsair Exp $

IUSE="qt"

DESCRIPTION="A full featured console-based audio mixer."
HOMEPAGE="http://ermixer.sourceforge.net"
LICENSE="GPL-2"

DEPEND=">=sys-libs/ncurses-5.2
		qt? ( x11-libs/qt )"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~amd64 ~ppc64"

SRC_URI="mirror://sourceforge/ermixer/${P}.tar.gz"
RESTRICT="nomirror"

src_compile() {
	if use qt; then
		econf --enable-qt || die
	else
		econf || die
	fi

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
