# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xmovie/xmovie-1.9.12.ebuild,v 1.1 2004/03/17 16:04:39 phosphan Exp $

DESCRIPTION="A Player for MPEG and Quicktime movies"
SRC_URI="mirror://sourceforge/heroines/${P}-src.tar.bz2"
HOMEPAGE="http://heroines.sourceforge.net/"

RDEPEND="virtual/x11
	=dev-libs/glib-1.2*
	>=media-libs/libpng-1.2.1"

DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"
IUSE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_compile() {
	./configure || die
	emake || die
}

src_install () {
	into /usr
	dobin xmovie/`uname -m`/xmovie
	dohtml xmovie/*.html
}
