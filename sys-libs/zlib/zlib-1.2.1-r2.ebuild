# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/zlib/zlib-1.2.1-r2.ebuild,v 1.7 2004/06/11 18:12:30 kloeri Exp $

inherit eutils flag-o-matic

DESCRIPTION="Standard (de)compression library"
HOMEPAGE="http://www.gzip.org/zlib/"
SRC_URI="http://www.gzip.org/zlib/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips alpha arm hppa amd64 ~ia64 ~ppc64 s390"
IUSE="build"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Make sure we link with glibc at all times
	epatch ${FILESDIR}/${P}-glibc.patch
	# Needed for Alpha and prelink
	epatch ${FILESDIR}/${P}-build-fPIC.patch
	# Only export global symbols, bug #32764
	epatch ${FILESDIR}/${P}-mapfile.patch
}

src_compile() {
	./configure --shared --prefix=/usr --libdir=/lib || die
	emake || die
	make test || die

	./configure --prefix=/usr --libdir=/lib || die
	emake || die
}

src_install() {
	einstall libdir=${D}/lib || die
	rm ${D}/lib/libz.a
	into /usr
	dodir /usr/include
	insinto /usr/include
	doins zconf.h zlib.h

	if ! use build ; then
		doman zlib.3
		dodoc FAQ README ChangeLog
		docinto txt
		dodoc algorithm.txt
	fi

	# we don't need the static lib in /lib
	# as it's only for compiling against
	into /usr
	dolib libz.a

	# all the shared libs go into /lib
	# for NFS based /usr
	into /
	dolib libz.so.${PV}
	( cd ${D}/lib ; chmod 755 libz.so.* )
	dosym libz.so.${PV} /lib/libz.so
	dosym libz.so.${PV} /lib/libz.so.1
	# with an extra symlink at /usr/lib
	dosym /lib/libz.so.${PV} /usr/lib/libz.so
}
