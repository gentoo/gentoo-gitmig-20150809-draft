# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/hearts/hearts-1.98.ebuild,v 1.2 2005/08/09 23:55:47 vapier Exp $

inherit eutils kde

DESCRIPTION="clone of the hearts game for KDE that comes with Windows"
HOMEPAGE="http://hearts.luispedro.org/index.php"
SRC_URI="mirror://sourceforge/hearts/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

need-kde 3

PATCHES="${FILESDIR}/${P}-gcc.patch"

src_install() {
	kde_src_install
	rm -r "${D}"/usr/share/applnk
	make_desktop_entry hearts Hearts
}
