# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Martin Schlemmer <azarah@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="Implements functions designed to lock the standard mailboxes."
SRC_URI="ftp://ftp.debian.org/debian/pool/main/libl/liblockfile/liblockfile_1.03.tar.gz"
HOMEPAGE="http://www.debian.org"

DEPEND="virtual/glibc"

RDEPEND="virtual/glibc"


src_compile() {

	./configure --with-mailgroup=mail --prefix=/usr --mandir=/usr/share/man
	make || die
	
}

src_install () {
	
	dodir /usr/bin /usr/include /usr/lib /usr/share/man/man1 /usr/share/man/man3
	make  ROOT=${D} install || die
	
}

