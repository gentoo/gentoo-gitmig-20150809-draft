# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/xd3d/xd3d-8.3.1.ebuild,v 1.9 2011/06/21 14:30:51 jlec Exp $

EAPI=2
inherit eutils fortran-2 toolchain-funcs

DESCRIPTION="scientific visualization tool"
HOMEPAGE="http://www.cmap.polytechnique.fr/~jouve/xd3d/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="
	virtual/fortran
x11-libs/libXpm"
DEPEND="${RDEPEND}
	app-shells/tcsh"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.diff
	epatch "${FILESDIR}"/${P}-parallel.patch
	epatch "${FILESDIR}"/${P}-rotated.patch
}

src_configure() {
	export FC=$(tc-getFC)
	sed -e "s:##D##:${D}:" \
		-e "s:##lib##:$(get_libdir):" \
		-i RULES.gentoo \
		|| die "failed to set up RULES.gentoo"
	./configure -arch=gentoo || die "configure failed."
}

src_install() {
	dodir /usr/bin
	emake install || die "emake install failed"

	dodoc BUGS CHANGELOG FAQ FORMATS README
	insinto /usr/share/doc/${PF}
	doins Manuals/* || die

	insinto /usr/share/doc/${PF}/examples
	doins -r Examples/* || die
}
