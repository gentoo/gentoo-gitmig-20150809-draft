# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/xmovie/xmovie-1.8-r3.ebuild,v 1.6 2003/09/07 00:08:13 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Player for MPEG and Quicktime movies"
SRC_URI="http://heroinewarrior.com/${P}.tar.gz"
HOMEPAGE="http://heroines.sourceforge.net/"

RDEPEND="virtual/x11
	=dev-libs/glib-1.2*
	>=media-libs/libpng-1.2.1"

DEPEND="${RDEPEND}
	>=dev-lang/nasm-0.98"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {
	local myconf
	use mmx || myconf="${myconf} --no-mmx"

	./configure ${myconf} || die
	emake || die

}

src_install () {

    into /usr
    dobin xmovie/`uname -m`/xmovie
    dodoc README
    dohtml docs/*.html

}
