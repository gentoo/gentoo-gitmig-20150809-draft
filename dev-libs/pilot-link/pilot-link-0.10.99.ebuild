# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# AJ Lewis <aj@gentoo.org>
#

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A suite of tools contains a series of conduits for moving
information to and from your Palm device and your desktop or workstation
system."

SRC_URI="http://pilot-link.org/source/${A}"
HOMEPAGE="http://www.pilot-link.org/"
DEPEND="virtual/glibc"

src_compile() {
	./configure --host=${CHOST}					\
		    --prefix=/usr/					\
		    --mandir=/usr/share/man 				\
		    --infodir=/usr/share/info				\
		    --includedir=/usr/include/libpisock			\
		    --with-tcl=no					\
		    --with-itcl=no 					\
		    --with-tk=no					\
		    --with-python=no					\
		    --with-java=no					\
		    --with-perl5=no
	assert

	cd ${S}
	emake || die
}

src_install() {

	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     includedir=${D}/usr/include/libpisock			\
	     infodir=${D}/usr/share/info				\
	     install || die

	dodoc COPYING COPYING.LIB ChangeLog README TODO 

}
