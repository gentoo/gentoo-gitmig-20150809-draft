# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.10.0.18-r1.ebuild,v 1.1 2000/08/03 14:16:17 achim Exp $

P=binutils-2.10.0.18
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Tools necessary to build programs"
CATEGORY="sys-devel"
SRC_URI="ftp://ftp.varesearch.com/pub/support/hjl/binutils/${A}"

src_compile() {                           
	./configure --prefix=/usr --host=${CHOST}
	make
}

src_install() {
	cd ${S}
                             
	into /usr
	doman binutils/*.1 gas/doc/as.1 gprof/gprof.1
	insinto /usr/lib
	doins bfd/libbfd.la bfd/libbfd.a opcodes/libopcodes.a opcodes/libopcodes.la libiberty/libiberty.a
	insinto /usr/include
	doins bfd/bfd.h include/ansidecl.h include/bfdlink.h
	cp binutils/nm-new binutils/nm
	cp binutils/strip-new binutils/strip
	cp gas/as-new gas/as
	cp gas/gasp-new gas/gasp
	cp ld/ld-new ld/ld
	cd binutils
	dobin addr2line ar cxxfilt nm objcopy objdump ranlib readelf size strings strip
	cd ..
	dobin ld/ld gprof/gprof gas/as gas/gasp
	dodir /usr/${CHOST}/bin
	for i in nm strip ar ranlib as ld
	do
	    dosym /usr/bin/${i} /usr/${CHOST}/bin/${i}
	done
	insinto /usr/${CHOST}/lib/ldscripts
	doins ld/ldscripts/* 
	dodoc COPYING* README* ChangeLog* mpw-README
	docinto bfd
        dodoc bfd/ChangeLog* bfd/COPYING bfd/README bfd/PORTING bfd/TODO
	docinto binutils
 	dodoc binutils/MAINTAINERS binutils/NEWS binutils/README
	docinto gas
	dodoc gas/ChangeLog* gas/CONTRIBUTORS gas/COPYING gas/MAINTAINERS gas/NEWS gas/README*
	docinto gprof
	dodoc gprof/ChangeLog* gprof/MAINTAINERS gprof/NOTES gprof/TEST gprof/TODO
	docinto include
	dodoc include/ChangeLog* include/COPYING include/MAINTAINERS
	docinto intl
	dodoc intl/ChangeLog
	docinto ld
	dodoc ld/ChangeLog* ld/MAINTAINERS ld/README ld/NEWS ld/TODO
	docinto libiberty
	dodoc libiberty/ChangeLog* libiberty/COPYING.LIB libiberty/README 
	docinto opcodes
	dodoc opcodes/ChangeLog* opcodes/MAINTAINERS
	
}



