# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/maloc/maloc-0.1.2.ebuild,v 1.2 2007/06/26 01:54:13 mr_bones_ Exp $

inherit eutils

MY_PV="0.1-2"

DESCRIPTION="MALOC is a small, portable, abstract C environment library for object-oriented C programming"
LICENSE="GPL-2"
HOMEPAGE="http://scicomp.ucsd.edu/~mholst/codes/maloc/index.html#overview"
SRC_URI=" http://cam.ucsd.edu/~mholst/codes/${PN}/${PN}-${MY_PV}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

DEPEND="sys-libs/readline"

S="${WORKDIR}/${PN}"

src_compile() {
	# do not build blas
	local myconf="--disable-blas"

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
