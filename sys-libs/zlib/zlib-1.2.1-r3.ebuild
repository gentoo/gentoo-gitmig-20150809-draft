# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/zlib/zlib-1.2.1-r3.ebuild,v 1.17 2005/03/13 12:00:11 vapier Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Standard (de)compression library"
HOMEPAGE="http://www.gzip.org/zlib/"
SRC_URI="http://www.gzip.org/zlib/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="build"

RDEPEND="virtual/libc"

pkg_setup() {
	tc-export CC RANLIB
	AR="$(tc-getAR) rc"
}

src_unpack() {
	unpack ${A}

	cd ${S}
	# Make sure we link with glibc at all times
	epatch ${FILESDIR}/${P}-glibc.patch
	# Needed for Alpha and prelink
	epatch ${FILESDIR}/${P}-build-fPIC.patch
	# Only export global symbols, bug #32764
	epatch ${FILESDIR}/${P}-mapfile.patch
	# The configure script can be kind of dumb #55434
	epatch ${FILESDIR}/${P}-configure.patch
	#security fix. bug #61749
	epatch ${FILESDIR}/${P}-CAN-2004-0797.patch
	# fix shared library test on -fPIC dependant archs
	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_compile() {
	./configure --shared --prefix=/usr --libdir=/$(get_libdir) || die
	emake || die

	./configure --prefix=/usr --libdir=/$(get_libdir) || die
	emake || die
}

src_install() {
	einstall libdir=${D}/$(get_libdir) || die
	rm "${D}"/$(get_libdir)/libz.a
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
	dolib libz.a

	# all the shared libs go into /lib
	# for NFS based /usr
	into /
	dolib libz.so.${PV}
	( cd ${D}/$(get_libdir) ; chmod 755 libz.so.* )
	dosym libz.so.${PV} /$(get_libdir)/libz.so
	dosym libz.so.${PV} /$(get_libdir)/libz.so.1
	gen_usr_ldscript libz.so
}
