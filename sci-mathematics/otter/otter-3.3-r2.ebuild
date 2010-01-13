# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/otter/otter-3.3-r2.ebuild,v 1.1 2010/01/13 02:29:46 markusle Exp $

EAPI="2"
inherit eutils

DESCRIPTION="An Automated Deduction System."
SRC_URI="http://www-unix.mcs.anl.gov/AR/${PN}/${P}.tar.gz"
HOMEPAGE="http://www-unix.mcs.anl.gov/AR/otter/"

KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
LICENSE="otter"
SLOT="0"
IUSE=""
DEPEND="virtual/libc"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	cd source
	CC=$(tc-getCC) emake || die "emake failed"
	cd "${S}"/mace2
	CC=$(tc-getCC) emake || die "emake in mace2 failed"
}

src_install() {
	dobin bin/* source/formed/formed \
		|| die "failed to install binaries"
	dodoc README* Legal Changelog Contents \
		|| die "failed to install regular docs"
	insinto /usr/share/doc/${PF}
	doins documents/*.pdf \
		|| die "failed to install pdf docs"
	insinto /usr/share/${PN}/
	doins -r examples examples-mace2 \
		|| die "failed to install examples"
}
