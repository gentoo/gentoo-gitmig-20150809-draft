# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/tapiir/tapiir-0.7.1.ebuild,v 1.1 2003/05/09 13:13:36 jje Exp $

DESCRIPTION=" Tapiir is a simple and flexible audio effects processor, inspired on the classical magnetic tape delay systems"
HOMEPAGE="http://www.iua.upf.es/~mdeboer/projects/tapiir/"
SRC_URI="ftp://www.iua.upf.es/pub/mdeboer/projects/tapiir/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"

DEPEND="virtual/jack
	>=media-sound/alsa-driver-0.9
	x11-libs/fltk"

src_compile() {
	local myconf
	myconf="--with-fltk-prefix=/usr/lib/fltk-1.1 \
		--with-fltk-inc-prefix=/usr/include/fltk-1.1"
	./configure ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS
}
