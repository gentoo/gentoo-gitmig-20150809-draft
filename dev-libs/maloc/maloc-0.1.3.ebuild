# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/maloc/maloc-0.1.3.ebuild,v 1.6 2010/01/06 17:56:46 darkside Exp $

inherit eutils

MY_PV="0.1-3"

DESCRIPTION="MALOC is a small, portable, abstract C environment library for object-oriented C programming"
LICENSE="GPL-2"
HOMEPAGE="http://scicomp.ucsd.edu/~mholst/codes/maloc/index.html#overview"
SRC_URI=" http://cam.ucsd.edu/~mholst/codes/${PN}/${PN}-${MY_PV}.tar.gz"

SLOT="0"
IUSE="mpi"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"

DEPEND="sys-libs/readline
		mpi? ( virtual/mpi )"

S="${WORKDIR}/${PN}"

src_compile() {
	# do not build blas
	local myconf="--disable-blas"

	if use mpi; then
		myconf="${myconf} --enable-mpi"
	fi

	# configure
	econf ${myconf} || die "configure failed"

	# fix install location of libs in Makefile
	sed -e "s|libdir = \${prefix}/lib/\${fetk_cpu_vendor_os}|libdir = \${prefix}/lib/|" \
		-i src/aaa_lib/Makefile || \
		die "failed to patch lib Makefile"

	# build
	make || die "make failed"
}

src_install() {

	# install libs and headers
	make DESTDIR="${D}" install || die "make install failed"

	# install doc
	dohtml doc/index.html || die "failed to install html docs"
}
