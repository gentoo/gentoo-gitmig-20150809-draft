# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/clapack/clapack-3.2.1-r1.ebuild,v 1.2 2010/03/31 19:46:29 jlec Exp $

EAPI="3"

inherit eutils multilib toolchain-funcs versionator

DESCRIPTION="f2c'ed version of LAPACK"
HOMEPAGE="http://www.netlib.org/clapack/"
SRC_URI="http://www.netlib.org/${PN}/${P}.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/libf2c-20081126[static-libs]"
DEPEND="${RDEPEND}"
S="${WORKDIR}"/CLAPACK-${PV}

src_prepare() {
	rm -rf F2CLIBS BLAS

	epatch "${FILESDIR}"/${PV}-solib.patch

	sed \
		-e "s:^CC.*$:CC = $(tc-getCC):g" \
		-e "s:^CFLAGS.*$:CFLAGS = ${CFLAGS} -fPIC:g" \
		-e "s:^LOADER.*$:LOADER = $(tc-getCC):g" \
		-e "s:^LOADOPTS.*$:LOADOPTS = ${LDFLAGS} -Wl,-soname,libclapack.so.$(get_version_component_range 1-2):g" \
		-e "s:LAPACKLIB.*$:LAPACKLIB = libclapack.so.${PV}:g" \
		make.inc.example > make.inc

	sed \
		-e 's:"f2c.h":<f2c.h>:g' \
		-i SRC/*.c || die
}

src_compile() {
	emake -C INSTALL F2CLIB="${EPREFIX}"/usr/$(get_libdir)/libf2c.a || die "compile failed"
	emake -C SRC || die "compile failed"
}

src_install() {
	insinto /usr/include
	doins INCLUDE/${PN}.h || die
	dolib.so lib${PN}.so.${PV} || die
	dosym lib${PN}.so.${PV} /usr/$(get_libdir)/lib${PN}.so.$(get_version_component_range 1-2) || die
	dosym lib${PN}.so.${PV} /usr/$(get_libdir)/lib${PN}.so.$(get_major_version) || die
	dosym lib${PN}.so.${PV} /usr/$(get_libdir)/lib${PN}.so || die
}
