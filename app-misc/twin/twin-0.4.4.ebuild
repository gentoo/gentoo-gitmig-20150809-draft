# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-misc/twin/twin-0.4.4.ebuild,v 1.1 2002/09/10 12:32:57 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A text-mode window environment"
SRC_URI="mirror://sourceforge/twin/${P}.tar.gz"
HOMEPAGE="http://twin.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc"

DEPEND="X? ( virtual/x11 )
	ggi? ( >=media-libs/libggi-1.9 )
	gtk? ( =x11-libs/gtk+-1.2* )
	>=sys-libs/gpm-1.19.3
	>=sys-libs/ncurses-5.2"
	
src_compile() {
	local myconf
	
	use X \
		&& myconf="--with-x --enable-hw-x11=yes"

	use ggi \
		&& myconf="${myconf} --enable-hw-ggi=yes" \
		|| myconf="${myconf} --enable-hw-ggi=no"

	use gtk \
		&& myconf="${myconf} --enable-tt-hw-gtk=yes" \
		|| myconf="${myconf} --enable-tt-hw-gtk=no"

	econf \
		--enable-shlibs=yes \
		--enable-modules=yes \
		--enable-unicode=yes \
		--enable-socket=yes \
		--enable-socket-gz=yes \
		--enable-socket-pthreads=yes \
		--enable-socket-alien=yes \
		--enable-h2-tty-termcap=yes \
		--enable-term=yes \
		${myconf} || die

	make || die
}

src_install() {
	
	einstall || die

	use X && ( \
		insinto /usr/X11R6/lib/X11/fonts/misc
		doins fonts/vga.pcf.gz
	)

	rm -rf ${D}/usr/share/twin/{BUGS,docs,COP*,READ*,Change*,INSTALL*} 

	dodoc BUGS COPYING* Change* README* TODO*
	dodoc docs/*

}

pkg_postinst() {	
	use X && ( \
		/usr/X11R6/bin/mkfontdir /usr/X11R6/lib/X11/fonts/misc
		/usr/X11R6/bin/xset fp rehash
	)
}

pkg_postrm() {
	use X && ( \
		/usr/X11R6/bin/mkfontdir /usr/X11R6/lib/X11/fonts/misc
		/usr/X11R6/bin/xset fp rehash
	)
}
