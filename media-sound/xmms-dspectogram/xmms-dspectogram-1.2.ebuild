# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms-dspectogram/xmms-dspectogram-1.2.ebuild,v 1.1 2002/05/22 23:55:57 george Exp $

SHORTNAME="dspectogram-1.2"
S=${WORKDIR}/${SHORTNAME}
DESCRIPTION="Dual spectral histogram visualization plugin for xmms"
SRC_URI="http://hem.passagen.se/joakime/${SHORTNAME}.tar.gz"
HOMEPAGE="http://hem.passagen.se/joakime/linuxapp.html"

LICENSE="GPL-2"

DEPEND="virtual/glibc
	sys-devel/gcc
	 >=media-sound/xmms-1.2.5-r1"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	cd ${S} || die
	# patch in DESTDIR support
	patch -p0 < ${FILESDIR}/${SHORTNAME}-destdir.patch || die
}

src_compile() {     
	# There is no configure script, but the
	# Makefile does things (mostly) correctly.
 	make clean || die
	emake OPT="$CFLAGS" || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README COPYING Changes
}
