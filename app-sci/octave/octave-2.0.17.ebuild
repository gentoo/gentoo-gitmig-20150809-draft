# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/octave/octave-2.0.17.ebuild,v 1.1 2002/07/13 22:56:47 raker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNU Octave is a high-level language (MatLab compatible) intended for numerical computations."
SRC_URI="ftp://ftp.octave.org/pub/octave/${P}.tar.bz2"
HOMEPAGE="http://www.octave.org/"

DEPEND="virtual/glibc
		>=sys-libs/ncurses-5.2-r3
		>=media-gfx/gnuplot-3.7.1-r3"
RDEPEND="${DEPEND}"
PROVIDE="dev-lang/octave"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

src_compile() {
	# NOTE: This version only works with gcc-2.x not gcc-3.x
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/state/octave \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		--build=${CHOST} \
		--host=${CHOST} \
		--target=${CHOST} \
		--enable-dl \
		--enable-shared \
		--enable-rpath \
		--enable-lite-kernel \	
		${myconf} || die "./configure failed"

	emake || die "emake failed"

}

src_install () {
	
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "make install failed"

	dodoc BUGS COPYING ChangeLog* INSTALL* NEWS* PROJECTS README* ROADMAP \
		SENDING-PATCHES THANKS

}
