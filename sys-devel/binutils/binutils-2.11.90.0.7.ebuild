# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.11.90.0.7.ebuild,v 1.3 2001/09/08 18:52:24 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Tools necessary to build programs"
SRC_URI="http://ftp.kernel.org/pub/linux/devel/binutils/${P}.tar.gz"

DEPEND="virtual/glibc"

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
	for x in *
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
    else
        rm -rf ${D}/usr/share/man
    fi
}



