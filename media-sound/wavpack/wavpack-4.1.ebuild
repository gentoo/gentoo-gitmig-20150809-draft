# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavpack/wavpack-4.1.ebuild,v 1.3 2004/12/19 06:59:42 eradicator Exp $

IUSE=""

DESCRIPTION="WavPack audio compression tools"
HOMEPAGE="http://www.wavpack.com/"
SRC_URI="http://www.wavpack.com/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 ~ppc sparc x86"

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	sys-devel/automake"

src_compile() {
	./autogen.sh || die
	econf || die
	emake || die
}

src_install() {
	dobin wavpack wvunpack
	dodoc *.txt
}
