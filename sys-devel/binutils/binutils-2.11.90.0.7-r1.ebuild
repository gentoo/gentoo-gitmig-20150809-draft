# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.11.90.0.7-r1.ebuild,v 1.6 2002/08/01 11:40:16 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tools necessary to build programs"
SRC_URI="http://ftp.kernel.org/pub/linux/devel/binutils/${P}.tar.gz http://www.ibiblio.org/${PN}-manpages-${PV}.tar.bz2"
LICENSE="GPL-2 LGPL-2 BINUTILS"
SLOT="0"
KEYWORDS="x86"
HOMEPAGE="http://sources.redhat.com/binutils/"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	#man pages are tarred up seperately because building them depends on perl, which isn't installed at
	#Gentoo Linux bootstrap time.
	mkdir man; cd man
	tar xjf ${DISTDIR}/${PN}-manpages-${PV}.tar.bz2
}

src_compile() {
	./configure --prefix=/usr --mandir=/usr/share/man --host=${CHOST} --without-included-gettext || die
    if [ "`use static`" ]
    then
        emake -e LDFLAGS=-all-static || die
    else
	    emake || die
    fi
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man install || die
    #c++filt is included with gcc -- what are these GNU people thinking?
	rm ${D}/usr/bin/c++filt ${D}/usr/share/man/man1/c++filt*
	
	#strip has a symlink going from /usr/${CHOST}/bin/strip to /usr/bin/strip; we should reverse
	#it:

	rm ${D}/usr/${CHOST}/bin/strip; mv ${D}/usr/bin/strip ${D}/usr/${CHOST}/bin/strip
	#the strip symlink gets created in the loop below
	
	#ar, as, ld, nm, ranlib and strip are in two places; create symlinks.  This will reduce the 
	#size of the tbz2 significantly.  We also move all the stuff in /usr/bin to /usr/${CHOST}/bin
	#and create the appropriate symlinks.  Things are cleaner that way.
	cd ${D}/usr/bin
	local x
	for x in * strip
	do
		if [ ! -e ../${CHOST}/bin/${x} ]
		then
			mv $x ../${CHOST}/bin/${x}
		else	
			rm -f $x
		fi
		ln -s ../${CHOST}/bin/${x} ${x}
	done
	cd ${S}
	if [ -z "`use build`" ]
    then
	    dodoc COPYING* README
	    docinto bfd
        dodoc bfd/ChangeLog* bfd/COPYING bfd/README bfd/PORTING bfd/TODO
	    docinto binutils
 	    dodoc binutils/ChangeLog binutils/NEWS binutils/README
	    docinto gas
	    dodoc gas/ChangeLog* gas/CONTRIBUTORS gas/COPYING gas/NEWS gas/README*
	    docinto gprof
	    dodoc gprof/ChangeLog* gprof/TEST gprof/TODO
	    docinto ld
	    dodoc ld/ChangeLog* ld/README ld/NEWS ld/TODO
	    docinto libiberty
	    dodoc libiberty/ChangeLog* libiberty/COPYING.LIB libiberty/README
	    docinto opcodes
	    dodoc opcodes/ChangeLog*
		rm -f ${D}/usr/share/man/man1/*
		doman ${S}/man/*.1
    else
        rm -rf ${D}/usr/share/man
    fi
}



