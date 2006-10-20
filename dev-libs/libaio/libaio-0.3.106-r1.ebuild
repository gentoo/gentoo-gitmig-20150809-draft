# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.106-r1.ebuild,v 1.7 2006/10/20 00:20:14 kloeri Exp $

inherit eutils multilib

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/
	http://lse.sourceforge.net/io/aio.html"
# Rip out of src rpm that Redhat uses:
# http://download.fedora.redhat.com/pub/fedora/linux/core/development/SRPMS/
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ppc ppc64 s390 x86"
IUSE=""

DEPEND=""

RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	EBUILD_ARCH=${ARCH}
	export ARCH=$HOSTTYPE
	einfo "Using ${ARCH}"
	make || die "make failed"
	export ARCH=${EBUILD_ARCH}
}

src_test() {
	cd ${S}/harness
	mkdir testdir
	make check prefix="${S}/src" libdir="${S}/src"
}

src_install() {
	make install prefix="${D}usr" libdir="${D}usr/$(get_libdir)" \
	    root=${D} || die "make install failed"
	doman man/*
	dodoc ChangeLog TODO COPYING

	# remove stuff provided by man-pages now
	rm "${D}"usr/share/man/man3/aio_{cancel,error,fsync,read,return,suspend,write}.*
}
