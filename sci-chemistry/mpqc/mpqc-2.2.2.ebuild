# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mpqc/mpqc-2.2.2.ebuild,v 1.3 2006/03/15 08:55:45 spyderous Exp $

DESCRIPTION="The Massively Parallel Quantum Chemistry Program"
HOMEPAGE="http://www.mpqc.org/"
SRC_URI="mirror://sourceforge/mpqc/${P}.tar.gz
	doc? ( mirror://sourceforge/mpqc/${PN}-man-${PV}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
# Should work on x86, amd64 and ppc, at least
KEYWORDS="x86 ~ppc amd64"
IUSE="doc"

DEPEND="sys-devel/flex
	sci-libs/blas
	sci-libs/lapack
	dev-lang/perl"

src_compile() {
	CFLAGS_SAVE=${CFLAGS}; CXXFLAGS_SAVE=${CXXFLAGS}
	myconf="${myconf} --prefix=/usr"
	./configure ${myconf} || die "configure failed"
	sed -e "s:^CFLAGS =.*$:CFLAGS=${CFLAGS_SAVE}:" \
	  -e "s:^FFLAGS =.*$:FFLAGS=${CFLAGS_SAVE}:" \
	  -e "s:^CXXFLAGS =.*$:CXXFLAGS=${CXXFLAGS_SAVE}:" \
	  lib/LocalMakefile > lib/LocalMakefile.foo
	mv lib/LocalMakefile.foo lib/LocalMakefile
	emake || die "emake failed"
}

src_install() {
	sed -e "s:^prefix=.*$:prefix=${D}/usr:" lib/LocalMakefile \
	  > lib/LocalMakefile.foo
	mv lib/LocalMakefile.foo lib/LocalMakefile
	use doc && doman ${WORKDIR}/${PN}-man-${PV}/man3/*
	make install install_devel install_inc || die "install failed"
}
