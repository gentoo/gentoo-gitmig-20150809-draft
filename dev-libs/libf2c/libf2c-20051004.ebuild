# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libf2c/libf2c-20051004.ebuild,v 1.2 2007/08/23 13:12:09 uberlord Exp $

inherit toolchain-funcs eutils

DESCRIPTION="Library that converts FORTRAN to C source."
HOMEPAGE="ftp://ftp.netlib.org/f2c/index.html"
#SRC_URI="ftp://ftp.netlib.org/f2c/${PN}.zip"
SRC_URI="mirror://gentoo/${P}.zip"

LICENSE="libf2c"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="virtual/libc
	app-arch/unzip"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-add-ofiles-dep.patch
}

src_compile() {
	emake \
		-f makefile.u \
		all \
		CFLAGS="${CFLAGS}" \
		CC="$(tc-getCC)" \
		|| die "all failed"

	# Clean up files so we can recompile PIC for the shared lib
	rm *.o || die "clean failed"

	emake \
		-f makefile.u \
		libf2c.so \
		CFLAGS="${CFLAGS} -fPIC" \
		CC="$(tc-getCC)" \
		|| die "libf2c.so failed"
}

src_install () {
	dolib.a libf2c.a || die "dolib.a failed"
	dolib libf2c.so || die "dolib failed"
	insinto /usr/include
	doins f2c.h || die "f2c.h install failed"
	dodoc README Notice || die "doc install failed"
}
