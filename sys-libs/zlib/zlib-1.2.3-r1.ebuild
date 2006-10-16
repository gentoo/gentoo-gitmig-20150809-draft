# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/zlib/zlib-1.2.3-r1.ebuild,v 1.2 2006/10/16 20:46:53 uberlord Exp $

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="Standard (de)compression library"
HOMEPAGE="http://www.zlib.net/"
SRC_URI="http://www.gzip.org/zlib/${P}.tar.bz2
	http://www.zlib.net/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="build"

RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-visibility-support.patch #149929
	# Make sure we link with glibc at all times
	epatch "${FILESDIR}"/${PN}-1.2.1-glibc.patch
	# Needed for Alpha and prelink
	epatch "${FILESDIR}"/${PN}-1.2.1-build-fPIC.patch
	epatch "${FILESDIR}"/${PN}-1.2.1-configure.patch #55434
	# fix shared library test on -fPIC dependant archs
	epatch "${FILESDIR}"/${PN}-1.2.1-fPIC.patch
	epatch "${FILESDIR}"/${PN}-1.2.3-r1-bsd-soname.patch #123571
	epatch "${FILESDIR}"/${PN}-1.2.3-LDFLAGS.patch #126718
	sed -i -e '/ldconfig/d' Makefile.in
}

src_compile() {
	tc-export CC RANLIB
	export AR="$(tc-getAR) rc"
	./configure --shared --prefix=/usr --libdir=/$(get_libdir) || die
	emake || die
}

src_install() {
	einstall libdir="${D}"/$(get_libdir) || die
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
	( cd "${D}"/$(get_libdir) ; chmod 755 libz.so.* )
	dosym libz.so.${PV} /$(get_libdir)/libz.so
	dosym libz.so.${PV} /$(get_libdir)/libz.so.1
	gen_usr_ldscript libz.so
}
