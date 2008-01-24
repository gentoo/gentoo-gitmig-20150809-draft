# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavpack/wavpack-4.40.0.ebuild,v 1.12 2008/01/24 10:31:14 drac Exp $

DESCRIPTION="WavPack audio compression tools"
HOMEPAGE="http://www.wavpack.com"
SRC_URI="http://www.${PN}.com/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="mips"
IUSE=""

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog README
}
