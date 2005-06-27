# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avrdude/avrdude-4.4.0-r1.ebuild,v 1.3 2005/06/27 07:48:28 corsair Exp $


inherit eutils

DESCRIPTION="AVR Downloader/UploaDEr"
HOMEPAGE="http://savannah.nongnu.org/projects/avrdude"
SRC_URI="http://savannah.nongnu.org/download/avrdude/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ppc64 ~x86"
IUSE=""

DEPEND="app-text/tetex
	sys-devel/flex
	sys-devel/bison
	sys-devel/gcc
	sys-libs/ncurses
	sys-apps/grep
	sys-libs/readline
	virtual/libc
	app-text/texi2html"

RDEPEND="virtual/libc
	sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/avrdude-html-doc-build-fix.patch
}


src_install() {
	emake DESTDIR=${D} install || die
}
