# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tom von Schwerdtner <tvon@etria.org>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="libdbi implements a database-independent abstraction layer in C"
SRC_URI="http://prdownloads.sourceforge.net/libdbi/${A}"
HOMEPAGE="http://libdbi.sourceforge.net/"


DEPEND="virtual/glibc"

src_compile() {

	local myconf

	./configure --prefix=/usr || die  
	# libdbi apparently dosent care about the configure options, because it 
	# finds and tries to build plugins for whatever db's are installed
	cd src/
	make || die
}

src_install() {

	make DESTDIR=${D} install || die
	insinto /usr/include/dbi 
	doins include/dbi/*.h

	cp -a doc/* ${D}/usr/doc/${PF}
	dodoc README README.plugins TODO INSTALL AUTHORS COYING ChangeLog
}

