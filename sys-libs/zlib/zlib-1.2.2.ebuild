# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/zlib/zlib-1.2.2.ebuild,v 1.1 2004/11/04 00:27:54 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Standard (de)compression library"
HOMEPAGE="http://www.gzip.org/zlib/"
SRC_URI="http://www.gzip.org/zlib/${P}.tar.bz2
	http://www.zlib.net/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="build"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	>=sys-devel/binutils-2.14.90.0.6"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Make sure we link with glibc at all times
	epatch ${FILESDIR}/${PN}-1.2.1-glibc.patch
	# Needed for Alpha and prelink
	epatch ${FILESDIR}/${PN}-1.2.1-build-fPIC.patch
	# Only export global symbols, bug #32764
	epatch ${FILESDIR}/${P}-mapfile.patch
	# The configure script can be kind of dumb #55434
	epatch ${FILESDIR}/${PN}-1.2.1-configure.patch
	# fix shared library test on -fPIC dependant archs
	epatch ${FILESDIR}/${PN}-1.2.1-fPIC.patch
}

src_compile() {
	./configure --shared --prefix=/usr --libdir=/$(get_libdir) || die
	emake || die
	make test || die

	./configure --prefix=/usr --libdir=/$(get_libdir) || die
	emake || die
}

src_install() {
	einstall libdir=${D}/$(get_libdir) || die
	rm ${D}/$(get_libdir)/libz.a
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
	( cd ${D}/$(get_libdir) ; chmod 755 libz.so.* )
	dosym libz.so.${PV} /$(get_libdir)/libz.so
	dosym libz.so.${PV} /$(get_libdir)/libz.so.1
	# with an extra symlink at /usr/lib
	dosym /$(get_libdir)/libz.so.${PV} /usr/$(get_libdir)/libz.so
}
