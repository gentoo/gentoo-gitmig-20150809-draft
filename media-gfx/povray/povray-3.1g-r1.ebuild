# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/povray/povray-3.1g-r1.ebuild,v 1.2 2002/04/27 23:08:36 bangert Exp $

S=${WORKDIR}/povray31
DESCRIPTION="POV Ray- The Persistance of Vision Ray Tracer"
SRC_URI="ftp://ftp.povray.org/pub/povray/Official/Unix/povuni_s.tgz
	ftp://ftp.povray.org/pub/povray/Official/Unix/povuni_d.tgz"
HOMEPAGE="http://www.povray.org/"

RDEPEND="virtual/glibc
	svga?   ( media-libs/svgalib )
	X?      ( virtual/x11 )
	media-libs/libpng
	sys-libs/zlib"

src_compile() {
	pwd
	patch -p1 < ${FILESDIR}/gentoo.patch
	cd source/unix
	emake newunix || die

	if [ "`use X`" ] ; then
		emake newxwin || die
	fi
	if [ "`use svga`" ] ; then
		make newsvga ||die
	fi
}

src_install() {
	pwd
	cd source/unix
	dodir usr/bin
	dodir usr/lib
	dodir usr/share/man/man1
	make DESTDIR=${D} install || die
	cd ${S}
	rm -rf source
	cd ..
	mv povray31 ${D}/usr/lib
}
