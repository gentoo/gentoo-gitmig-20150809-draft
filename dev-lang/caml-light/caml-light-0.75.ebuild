# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/caml-light/caml-light-0.75.ebuild,v 1.3 2006/11/03 10:10:11 nattfodd Exp $

inherit flag-o-matic eutils

DESCRIPTION="Caml-type language used in the french Computer Science lessons of the Preparatory Classes"
HOMEPAGE="http://pauillac.inria.fr/caml/distrib-caml-light-fra.html"

SRC_URI="ftp://ftp.inria.fr/INRIA/caml-light/cl75unix.tar.gz"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="tk"

DEPEND="virtual/libc
	tk? ( >=dev-lang/tk-3.3.3 )"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/cl75/src
}

pkg_setup() {
	ewarn
	ewarn "Building caml-light with unsafe CFLAGS can have unexpected results"
	ewarn "Please retry building with safer CFLAGS before reporting bugs"
	ewarn
}

src_compile() {
	filter-flags "-fstack-protector"
	replace-flags "-O?" -O2
	cd ${WORKDIR}/cl75/src
	make BINDIR=/usr/bin \
		LIBDIR=/usr/lib/caml-light \
		MANDIR=/usr/share/man \
		configure || die

	make BINDIR=/usr/bin \
		LIBDIR=/usr/lib/caml-light \
		MANDIR=/usr/share/man \
		world || die
}

src_install() {
	cd ${WORKDIR}/cl75/src
	mkdir -p ${D}usr/bin
	mkdir -p ${D}usr/lib/caml-light
	mkdir -p ${D}usr/share/man
	make BINDIR=${D}usr/bin \
		LIBDIR=${D}usr/lib/caml-light \
		MANDIR=${D}usr/share/man \
		install || die

}
