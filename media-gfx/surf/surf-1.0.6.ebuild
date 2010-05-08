# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/surf/surf-1.0.6.ebuild,v 1.1 2010/05/08 07:30:39 matsuu Exp $

EAPI="2"

DESCRIPTION="a tool to visualize algebraic curves and algebraic surfaces"
HOMEPAGE="http://surf.sourceforge.net/"
SRC_URI="mirror://sourceforge/surf/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
IUSE="cups"

RDEPEND="x11-libs/gtk+:1
	cups? ( net-print/cups )
	>=dev-libs/gmp-2
	sys-libs/zlib
	media-libs/tiff
	media-libs/jpeg"

DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5"

src_configure() {
	econf $(use_enable cups) || die
}

src_install() {
	emake DESTDIR="${D}" install install-man || die

	dodoc AUTHORS ChangeLog NEWS README TODO || die
	for d in examples/*
	do
		docinto ${d} || die
		dodoc ${d}/* || die
	done
}
