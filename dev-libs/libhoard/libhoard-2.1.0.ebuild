# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libhoard/libhoard-2.1.0.ebuild,v 1.3 2002/08/14 11:52:27 murphy Exp $

inherit libtool

DESCRIPTION="A fast, scalable and memory-efficient allocator for multiprocessors"
HOMEPAGE="http://www.hoard.org/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc"

src_compile() {
	# update libtool
	elibtoolize

	# enable the GNU extensions
	export CPPFLAGS=-D_GNU_SOURCE

	econf || die "./configure failed"
	emake || die "compilation failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc NEWS README docs/*
}
