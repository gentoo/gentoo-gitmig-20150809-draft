# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/catdvi/catdvi-0.14.ebuild,v 1.4 2008/09/11 19:11:12 maekke Exp $

inherit toolchain-funcs

DESCRIPTION="DVI to plain text translator"
HOMEPAGE="http://catdvi.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/tex-base"
RDEPEND="${DEPEND}"

src_compile() {
	econf || die "econf failed."
	# Do not use plain emake here, because make tests
	# may cache fonts and generate sandbox violations.
	emake catdvi CC="$(tc-getCC)" || die "emake failed."
}

src_install() {
	dobin catdvi
	doman catdvi.1
	dodoc AUTHORS ChangeLog NEWS README TODO
}
