# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/xd3d/xd3d-8.3.1.ebuild,v 1.2 2008/04/04 10:10:12 bicatali Exp $

inherit fortran toolchain-funcs multilib

DESCRIPTION="scientific visualization tool"
HOMEPAGE="http://www.cmap.polytechnique.fr/~jouve/xd3d/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86 ~amd64"
IUSE=""

RDEPEND="x11-libs/libXpm"

DEPEND="${RDEPEND}
	app-shells/tcsh"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.diff
}

src_compile() {
	sed -e "s:##D##:${D}:" \
		-e "s:##lib##:$(get_libdir):" \
		-e "s:##FC##:${FORTRANC}:" \
		-e "s:##CC##:$(tc-getCC):" \
		-e "s:##FFLAGS##:${FFLAGS}:" \
		-e "s:##CFLAGS##:${CFLAGS}:" \
		-i RULES.gentoo \
		|| die "failed to set up RULES.gentoo"
	./configure -arch=gentoo || die "configure failed."
	emake || die "emake failed."
}

src_install() {
	dodir /usr/bin
	emake install || die "emake install failed"

	dodoc BUGS CHANGELOG FAQ FORMATS INSTALL README || die
	insinto /usr/share/doc/${PF}
	doins Manuals/* || die

	insinto /usr/share/doc/${PF}/examples
	doins -r Examples/* || die
}
