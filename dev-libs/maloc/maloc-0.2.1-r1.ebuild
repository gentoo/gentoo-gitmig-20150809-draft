# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/maloc/maloc-0.2.1-r1.ebuild,v 1.1 2010/03/28 16:24:59 jlec Exp $

EAPI="3"

inherit autotools eutils

MY_PV="0.2-1"

DESCRIPTION="Small, portable, abstract C environment library for object-oriented C programming"
HOMEPAGE="http://scicomp.ucsd.edu/~mholst/codes/maloc/index.html#overview"
SRC_URI=" http://cam.ucsd.edu/~mholst/codes/${PN}/${PN}-${MY_PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
IUSE="mpi"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"

DEPEND="
	sys-libs/readline
	mpi? ( virtual/mpi )"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-mpi.patch
	eautoreconf
}

src_configure() {
	# fix install location of libs in Makefile
	sed -e "s|libdir = \${prefix}/lib/\${fetk_cpu_vendor_os}|libdir = \${prefix}/$(get_libdir)/|" \
		-i src/aaa_lib/Makefile.in || \
		die "failed to patch lib Makefile"

	econf $(use_enable mpi)
}

src_install() {
	# install libs and headers
	emake DESTDIR="${D}" install || die "make install failed"

	# install doc
	dohtml doc/index.html || die "failed to install html docs"
}
