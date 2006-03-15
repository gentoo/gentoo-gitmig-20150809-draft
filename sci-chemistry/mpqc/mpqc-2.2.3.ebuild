# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mpqc/mpqc-2.2.3.ebuild,v 1.4 2006/03/15 08:55:45 spyderous Exp $

inherit fortran

DESCRIPTION="The Massively Parallel Quantum Chemistry Program"
HOMEPAGE="http://www.mpqc.org/"
SRC_URI="mirror://sourceforge/mpqc/${P}.tar.bz2
	doc? ( mirror://sourceforge/mpqc/${PN}-man-${PV}.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
# Should work on x86, amd64 and ppc, at least
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc threads"

DEPEND="sys-devel/flex
	virtual/blas
	virtual/lapack
	dev-lang/perl
	>=sys-apps/sed-4"

src_compile() {
	CFLAGS_SAVE=${CFLAGS}; CXXFLAGS_SAVE=${CXXFLAGS}
	myconf="${myconf} --prefix=/usr"

	# only shared will work on ppc64 - bug #62124
	if use ppc64; then
		myconf="${myconf} --enable-shared"
	fi

	./configure \
		$(use_enable threads) \
		${myconf} || die "configure failed"
	sed -i -e "s:^CFLAGS =.*$:CFLAGS=${CFLAGS_SAVE}:" \
		-e "s:^FFLAGS =.*$:FFLAGS=${CFLAGS_SAVE}:" \
		-e "s:^CXXFLAGS =.*$:CXXFLAGS=${CXXFLAGS_SAVE}:" \
		lib/LocalMakefile
	emake || die "emake failed"
}

src_install() {
	sed -i -e "s:^prefix=.*$:prefix=${D}/usr:" lib/LocalMakefile
	use doc && doman ${WORKDIR}/${PN}-man-${PV}/man3/*
	make install install_devel install_inc || die "install failed"
}
