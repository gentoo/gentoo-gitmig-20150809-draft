# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/catdvi/catdvi-0.14-r1.ebuild,v 1.1 2010/10/27 21:54:21 ulm Exp $

EAPI=2

inherit eutils toolchain-funcs

DESCRIPTION="DVI to plain text translator"
HOMEPAGE="http://catdvi.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/tex-base"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-kpathsea.patch"
}

src_compile() {
	# Do not use plain emake here, because make tests
	# may cache fonts and generate sandbox violations.
	emake catdvi CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin catdvi || die
	doman catdvi.1 || die
	dodoc AUTHORS ChangeLog NEWS README TODO || die
}
