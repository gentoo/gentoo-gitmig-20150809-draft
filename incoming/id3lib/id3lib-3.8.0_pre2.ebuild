# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tom von Schwerdtner <tvon@etria.org>

A=${PN}-3.8.0pre2.tar.gz
S=${WORKDIR}/${PN}-3.8.0pre2
DESCRIPTION="Id3 library for C/C++"
SRC_URI="http://prdownloads.sourceforge.net/id3lib/${A}"
HOMEPAGE="http://id3lib.sourceforge.net/"

DEPEND="virtual/glibc"

src_compile() {

	./configure --host=${CHOST} --prefix=/usr --libexecdir=/usr/lib \
		--infodir=/usr/share/info || die
	make || die
}

src_install() {

	make DESTDIR=${D} install || die

#	make install takes care of this
# 	cp -a include/id3* ${D}/usr/include
	dodoc AUTHORS COPYING ChangeLog HISTORY INSTALL README THANKS TODO
#	some example programs to be placed in docs dir.
	cp -a examples ${D}/usr/share/doc/${PF}/examples
}

