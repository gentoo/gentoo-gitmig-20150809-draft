# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libnova/libnova-0.12.1.ebuild,v 1.1 2007/11/25 19:52:46 bicatali Exp $

inherit eutils autotools flag-o-matic

DESCRIPTION="Celestial Mechanics and Astronomical Calculation Library"
HOMEPAGE="http://libnova.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( app-doc/doxygen )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	# patch to use user's cflags and make doxygen working
	epatch "${FILESDIR}"/${P}-configure.patch
	eautoconf
}

src_compile() {
	# 0.12.1 does not pass test with > -02
	replace-flags -O? -O1

	econf || die "econf failed"
	emake || die "emake failed"
	if use doc; then
		cd doc
		emake doc || die "emake in doc failed"
	fi
}

src_test() {
	emake check || die "emake check failed"
	"${S}"/lntest/lntest || die "lntest failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die
	if use doc; then
		dohtml doc/html/* || die "dohtml failed"
		make clean
		rm -f examples/Makefile*
		insinto /usr/share/doc/${PF}
		doins -r examples
	fi
}
