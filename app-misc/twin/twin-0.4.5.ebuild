# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/twin/twin-0.4.5.ebuild,v 1.11 2004/02/17 23:48:08 vapier Exp $

DESCRIPTION="A text-mode window environment"
HOMEPAGE="http://twin.sourceforge.net/"
SRC_URI="mirror://sourceforge/twin/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~amd64 hppa alpha ia64"
IUSE="X gtk ggi"

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
		${myconf} \
		|| die
	make || die
}

src_install() {
	einstall || die

	if [ `use X` ] ; then
		insinto /usr/X11R6/lib/X11/fonts/misc
		doins fonts/vga.pcf.gz
	fi

	rm -rf ${D}/usr/share/twin/{BUGS,docs,COP*,READ*,Change*,INSTALL*}

	dodoc BUGS COPYING* Change* README* TODO/TODO TODO/twin-thoughts
	doman docs/twin.1; rm -rf docs/twin.1
	dodoc docs/*

}

pkg_postinst() {
	if [ `use X` ] ; then
		/usr/X11R6/bin/mkfontdir /usr/X11R6/lib/X11/fonts/misc
		/usr/X11R6/bin/xset fp rehash
	fi
}

pkg_postrm() {
	if [ `use X` ] ; then
		/usr/X11R6/bin/mkfontdir /usr/X11R6/lib/X11/fonts/misc
		/usr/X11R6/bin/xset fp rehash
	fi
}
