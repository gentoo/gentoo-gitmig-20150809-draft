# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tom von Schwerdtner <tvon@etria.org>

PARENT=id3lib-3.8.0pre2
A=${PARENT}.tar.gz
S=${WORKDIR}/${PARENT}
DESCRIPTION="Id3 library for C/C++ -- API Refrence"
SRC_URI="http://prdownloads.sourceforge.net/id3lib/${A}"
HOMEPAGE="http://id3lib.sourceforge.net/"


DEPEND="virtual/glibc
		app-doc/doxygen
		media-libs/id3lib"

src_compile() {

	cd doc/
	/usr/bin/doxygen Doxyfile

}

src_install() {

	# Using ${D} here dosent seem to work. Advice?
	dodir /usr/share/doc/${P}
	cp -a doc/* ${D}/usr/share/doc/${P}/
}

