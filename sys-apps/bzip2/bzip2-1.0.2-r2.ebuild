# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bzip2/bzip2-1.0.2-r2.ebuild,v 1.22 2003/06/21 21:19:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A high-quality data compressor used extensively by Gentoo Linux"
SRC_URI="ftp://sources.redhat.com/pub/bzip2/v102/${P}.tar.gz"
HOMEPAGE="http://sources.redhat.com/bzip2/"

KEYWORDS="x86 amd64 ppc sparc alpha mips hppa arm"
SLOT="0"
LICENSE="BZIP2"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	
	cd ${S}
	cp Makefile Makefile.orig
	# for optimizations, we keep -fomit-frame-pointer and -fno-strength-reduce
	# for speed.  -fstrength-reduce seems to slow down the code slightly on x86.
	# (drobbins)
	sed -e 's:\$(PREFIX)/man:\$(PREFIX)/share/man:g' \
		-e "s:-O2:${CFLAGS}:g" \
		Makefile.orig > Makefile || die
	cp Makefile-libbz2_so Makefile-libbz2_so.orig
	sed -e "s:-O2:${CFLAGS}:g" \
		Makefile-libbz2_so.orig > Makefile-libbz2_so || die
}

src_compile() {
	if [ -z "`use build`" ]
	then
		emake CC="${CC}" CXX="${CXX}" -f Makefile-libbz2_so all || die "Make failed"
	fi
	emake CC="${CC}" CXX="${CXX}" all || die "Make failed"
}

src_install() {
	if [ -z "`use build`" ]
	then
		make PREFIX=${D}/usr install || die
		mv ${D}/usr/bin ${D}
		
		dolib.so ${S}/libbz2.so.${PV}
		dosym /usr/lib/libbz2.so.${PV} /usr/lib/libbz2.so.1.0
		dosym /usr/lib/libbz2.so.${PV} /usr/lib/libbz2.so
		
		dodoc README LICENSE CHANGES Y2K_INFO
		docinto txt
		dodoc *.txt
		docinto ps
		dodoc *.ps
		dohtml manual_*.html
	else
		into /
		dobin bzip2
		newbin bzip2 bzcat
		
		cd ${D}/bin
		ln -s bzip2 bunzip2        
	fi
}

