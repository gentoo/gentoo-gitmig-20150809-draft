# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libhoard/libhoard-2.1.0.ebuild,v 1.1 2002/06/10 02:06:51 rphillips Exp $

DESCRIPTION="A fast, scalable and memory-efficient allocator for multiprocessors"
HOMEPAGE="http://www.hoard.org/"
LICENSE="LGPL-2.1"
DEPEND="virtual/glibc"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

src_compile() {
	# update libtool
	libtoolize --copy --force

	# enable the GNU extensions
	export CPPFLAGS=-D_GNU_SOURCE

	econf || die "./configure failed"
	emake || die "compilation failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc NEWS README docs/*
}

