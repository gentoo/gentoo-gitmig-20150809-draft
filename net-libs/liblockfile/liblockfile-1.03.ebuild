# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later

S=${WORKDIR}/${P}
DESCRIPTION="Implements functions designed to lock the standard mailboxes."
SRC_URI="ftp://ftp.debian.org/debian/pool/main/libl/liblockfile/liblockfile_1.03.tar.gz"
HOMEPAGE="http://www.debian.org"

DEPEND="virtual/glibc"


src_compile() {

	./configure --host=${CHOST}					\
		    --with-mailgroup=mail				\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info || die
		    
	emake || die
}

src_install() {
	
	dodir /usr/{bin,include,lib} /usr/share/man/{man1,man3}
	make  ROOT=${D} install || die
}

