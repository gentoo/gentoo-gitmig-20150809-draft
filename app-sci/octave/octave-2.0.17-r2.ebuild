# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/octave/octave-2.0.17-r2.ebuild,v 1.5 2003/12/30 17:09:38 usata Exp $

inherit flag-o-matic

IUSE=""

S=${WORKDIR}/${P}

DESCRIPTION="A high-level language (MatLab compatible) intended for numerical computations."
SRC_URI="ftp://ftp.octave.org/pub/octave/${P}.tar.bz2"
HOMEPAGE="http://www.octave.org/"

DEPEND=">=sys-libs/ncurses-5.2-r3
	virtual/tetex
	>=media-gfx/gnuplot-3.7.1-r3"

LICENSE="GPL-2"
KEYWORDS="x86 ppc"
SLOT="0"

src_compile() {

	filter-flags -ffast-math

	# NOTE: This version only works with gcc-2.x not gcc-3.x
	econf \
		--enable-dl \
		--enable-shared \
		--enable-rpath \
		--enable-lite-kernel \
		${myconf} || die "configure failed"

	make || die "make failed"

}

src_install () {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		datadir=${D}/usr/share \
		install || die "make install failed"

#	DESTDIR=${D} make install || die

	dodoc BUGS COPYING ChangeLog* INSTALL* NEWS* PROJECTS README* ROADMAP \
		SENDING-PATCHES THANKS

}
