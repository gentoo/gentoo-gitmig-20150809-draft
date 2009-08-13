# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/poker-eval/poker-eval-136.0.ebuild,v 1.1 2009/08/13 00:49:24 mr_bones_ Exp $
EAPI=2

inherit eutils

DESCRIPTION="A fast C library for evaluating poker hands"
HOMEPAGE="http://pokersource.info/"
SRC_URI="http://download.gna.org/pokersource/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

src_prepare() {
	epatch "${FILESDIR}"/${P}-bash40.patch
}

src_configure() {
	econf --without-ccache || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO WHATS-HERE
}
