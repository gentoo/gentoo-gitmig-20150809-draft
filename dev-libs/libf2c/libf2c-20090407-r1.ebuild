# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libf2c/libf2c-20090407-r1.ebuild,v 1.10 2012/06/06 03:32:37 zmedico Exp $

EAPI=2
inherit eutils multilib toolchain-funcs

DESCRIPTION="Library that converts FORTRAN to C source."
HOMEPAGE="ftp://ftp.netlib.org/f2c/index.html"
# copy this one and rename it on the gentoo mirrors
#SRC_URI="ftp://ftp.netlib.org/f2c/${PN}.zip"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="static-libs"

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"

S="${WORKDIR}/${PN}"

src_prepare() {
	epatch \
		"${FILESDIR}"/20051004-add-ofiles-dep.patch \
		"${FILESDIR}"/${PV}-link-shared-libf2c-correctly.patch \
		"${FILESDIR}"/${PV}-main.patch
}

src_compile() {
	emake \
		-f makefile.u \
		libf2c.so \
		CFLAGS="${CFLAGS} -fPIC" \
		CC="$(tc-getCC)" \
		|| die "libf2c.so failed"

	# Clean up files so we can recompile without PIC for the static lib
	if use static-libs; then
		rm *.o || die "clean failed"
		emake \
			-f makefile.u \
			all \
			CFLAGS="${CFLAGS}" \
			CC="$(tc-getCC)" \
			|| die "all failed"
	fi
}

src_install () {
	dolib libf2c.so.2 || die "dolib failed"
	dosym libf2c.so.2 /usr/$(get_libdir)/libf2c.so
	if use static-libs; then
		dolib.a libf2c.a || die "dolib.a failed"
	fi
	insinto /usr/include
	doins f2c.h || die "f2c.h install failed"
	dodoc README Notice || die "doc install failed"
}
