# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libogg/libogg-1.0.ebuild,v 1.18 2004/11/08 15:38:56 vapier Exp $

DESCRIPTION="the Ogg media file format library"
HOMEPAGE="http://www.xiph.org/ogg/vorbis/index.html"
SRC_URI="http://fatpipe.vorbis.com/files/1.0/unix/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc sparc x86"
IUSE=""

DEPEND="virtual/libc"

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
