# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/mix2000/mix2000-1.0.ebuild,v 1.1 2002/06/18 20:55:28 rphillips Exp $

S=${WORKDIR}/mix-2000
DESCRIPTION="The OSS sound mixer from the bcast2000 people; now orphaned."

# This is an uglier version, without glib and png support
#SRC_URI="http://www.tux.org/pub/packages/orphaned/broadcast2000/mix2000.tar.gz"
SRC_URI="http://diddl.firehead.org/software/unix/media/heroine/mix-2000-src.tar.gz"

DEPEND="virtual/glibc				
		virtual/x11					
		>=dev-libs/glib-1.2.0		
		>=media-libs/libpng-1.0.3	
		>=sys-libs/zlib-1.1.4"

src_compile() {
	cp configure configure.orig
	sed -e '/^CFLAGS +=/s:$: -I/usr/X11R6/include:'	\
		-e '/^LIBS =/s/-lglib/$(glib-config --libs)/'	\
		< configure.orig > configure
	./configure || die
	make || die
}

src_install () {
	dodoc README COPYING
	dobin mix/mix2000
}
