# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libogg/libogg-1.0.ebuild,v 1.9 2003/07/04 22:03:40 gmsoft Exp $

S=${WORKDIR}/${P}
DESCRIPTION="the Ogg media file format library"
SRC_URI="http://fatpipe.vorbis.com/files/1.0/unix/${P}.tar.gz"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"

DEPEND="virtual/glibc"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha hppa"

src_compile() {
	./configure --prefix=/usr --host=${CHOST} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
    
	# remove the docs installed by make install, since I'll install
	# them in portage package doc directory
	echo "Removing docs installed by make install"
	rm -rf ${D}/usr/share/doc

	dodoc AUTHORS CHANGES COPYING README
	dohtml doc/*.{html,png}
}

pkg_postinst() {
	einfo 
	einfo "Note the 1.0 version of libogg has been installed"
	einfo "Applications that used pre-1.0 ogg libraries will"
	einfo "need to be recompiled for the new version."
	einfo "Now that the vorbis folks have finalized the API"
	einfo "this should be the last time for a while that"
	einfo "recompilation is needed for these things."
	einfo
}
