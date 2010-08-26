# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libaio/libaio-0.3.109.ebuild,v 1.2 2010/08/26 02:51:45 reavertm Exp $

EAPI="3"

inherit eutils multilib toolchain-funcs

DESCRIPTION="Asynchronous input/output library that uses the kernels native interface"
HOMEPAGE="http://www.kernel.org/pub/linux/kernel/people/andrea/libaio/ http://lse.sourceforge.net/io/aio.html"
SRC_URI="mirror://kernel/linux/libs/aio/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="static-libs"

RESTRICT="test"

src_prepare() {
	# FIXME epatch "${FILESDIR}"/${PN}-0.3.107-sparc.patch        # not applicable anymore, may need porting
	# FIXME epatch "${FILESDIR}"/${PN}-0.3.107-generic-arch.patch # not applicable anymore but arm support now upstream
	epatch "${FILESDIR}"/${PN}-0.3.106-build.patch
	epatch "${FILESDIR}"/${PN}-0.3.107-ar-ranlib.patch
	epatch "${FILESDIR}"/${P}-install.patch
}

src_configure() {
	tc-export AR CC RANLIB
}

src_test() {
	cd "${S}"/harness
	mkdir testdir
	emake check prefix="${S}/src" libdir="${S}/src"
}

src_install() {
	emake install DESTDIR="${D}" LIBDIR=$(get_libdir) || die
	doman man/*
	dodoc ChangeLog TODO

	if ! use static-libs; then
		rm "${ED}"usr/lib*/*.a || die
	else
		gen_usr_ldscript libaio.so
	fi

	# remove stuff provided by man-pages now
	rm "${ED}"usr/share/man/man3/aio_{cancel,error,fsync,read,return,suspend,write}.*
}
