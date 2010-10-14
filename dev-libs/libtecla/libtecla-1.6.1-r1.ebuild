# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libtecla/libtecla-1.6.1-r1.ebuild,v 1.1 2010/10/14 13:44:53 xarthisius Exp $

EAPI=2

inherit autotools eutils flag-o-matic

DESCRIPTION="Tecla command-line editing library"
HOMEPAGE="http://www.astro.caltech.edu/~mcs/tecla/"
SRC_URI="http://www.astro.caltech.edu/~mcs/tecla/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

S=${WORKDIR}/libtecla

src_prepare() {
	epatch "${FILESDIR}"/${P}-install.patch \
		"${FILESDIR}"/${P}-ldflags.patch \
		"${FILESDIR}"/${P}-no-strip.patch
	# remove build directory from RPATH (see bug #119477)
	sed -e "s|:\$\$LD_RUN_PATH:\`pwd\`||" -i Makefile.rules || \
		die "Failed to adjust Makefile.rules"
	epatch "${FILESDIR}"/${P}-parallel_build.patch
	eautoreconf
}

src_compile() {
	emake LFLAGS="$(raw-ldflags)" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc CHANGES INSTALL PORTING README RELEASE.NOTES || die
}
