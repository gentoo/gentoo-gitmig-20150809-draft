# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/octave/octave-2.0.16.ebuild,v 1.2 2002/07/11 06:30:18 drobbins Exp $

S=${WORKDIR}/${P}

DESCRIPTION="GNU Octave is a high-level language (MatLab compatible) intended for numerical computations."

SRC_URI="ftp://ftp.octave.org/pub/octave/${P}.tar.bz2"

HOMEPAGE="http://www.octave.org/"

DEPEND="virtual/glibc
		>=sys-libs/ncurses-5.2-r3
		>=media-gfx/gnuplot-3.7.1"

PROVIDE="dev-lang/octave"

src_compile() {

	local myconf="--enable-shared --enable-dl --enable-lite-kernel"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	emake || die

}

src_install () {
	
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc BUGS COPYING ChangeLog* INSTALL* NEWS* PROJECTS README* ROADMAP \
		SENDING-PATCHES THANKS

}
