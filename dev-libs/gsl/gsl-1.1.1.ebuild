# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/dev-libs/gsl/gsl-1.0.ebuild,v 1.1 2002/01/12 15:24:19 verwilst Exp

S=${WORKDIR}/${P}

DESCRIPTION="The GNU Scientific Library"

SRC_URI="http://mirrors.rcn.net/pub/sourceware/gsl/${P}.tar.gz"

HOMEPAGE="http://sources.redhat.com/gsl/"

DEPEND="virtual/glibc"

src_compile() {
 	
#Avoid locking (can break parallel builds) 	
 	local myconf
 	myconf="--disable-libtool-lock"
	
	./configure --infodir=/usr/share/info \
				--mandir=/usr/share/man \
				--prefix=/usr \
				--host=${CHOST} \
				${myconf} || die
	
	emake || die

#Uncomment the 'make check ...' line if you want to run the test suite.
#Note that the check.log file will be several megabytes in size.	
#	make check > check.log 2>&1 || die

}

src_install () {

	make prefix=${D}/usr \
	infodir=${D}/usr/share/info \
	mandir=${D}/usr/share/man \
	install || die
	
	dodoc AUTHORS COPYING ChangeLog INSTALL KNOWN-PROBLEMS MACHINES 
NEWS

}



