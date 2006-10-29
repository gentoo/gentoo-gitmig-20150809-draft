# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavpack/wavpack-4.1.ebuild,v 1.6 2006/10/29 22:33:29 flameeyes Exp $

WANT_AUTOMAKE="1.7"
WANT_AUTOCONF="latest"

inherit autotools

IUSE=""

DESCRIPTION="WavPack audio compression tools"
HOMEPAGE="http://www.wavpack.com/"
SRC_URI="http://www.wavpack.com/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="-amd64 ~ppc sparc x86"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	eautoreconf
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dobin wavpack wvunpack
	dodoc *.txt
}
