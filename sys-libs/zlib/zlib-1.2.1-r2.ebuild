# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/zlib/zlib-1.2.1-r2.ebuild,v 1.14 2004/09/03 18:24:08 pvdabeel Exp $

inherit eutils flag-o-matic

DESCRIPTION="Standard (de)compression library"
HOMEPAGE="http://www.gzip.org/zlib/"
SRC_URI="http://www.gzip.org/zlib/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ~ia64 ~ppc64 s390"
IUSE="build"

DEPEND="virtual/libc"

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
}

pkg_setup() {
	# this adds support for installing to lib64/lib32. since only portage
	# 2.0.51 will have this functionality supported in dolib and friends,
	# and since it isnt expected that many profiles will define it, we need
	# to make this variable default to lib.
	[ -z "${CONF_LIBDIR}" ] && export CONF_LIBDIR="lib"
}

src_compile() {
	./configure --shared --prefix=/usr --libdir=/${CONF_LIBDIR} || die
	emake || die
	make test || die

	./configure --prefix=/usr --libdir=/${CONF_LIBDIR} || die
	emake || die
}

src_install() {
	einstall libdir=${D}/${CONF_LIBDIR} || die
	rm ${D}/${CONF_LIBDIR}/libz.a
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
	( cd ${D}/${CONF_LIBDIR} ; chmod 755 libz.so.* )
	dosym libz.so.${PV} /${CONF_LIBDIR}/libz.so
	dosym libz.so.${PV} /${CONF_LIBDIR}/libz.so.1
	# with an extra symlink at /usr/lib
	dosym /${CONF_LIBDIR}/libz.so.${PV} /usr/${CONF_LIBDIR}/libz.so
}
