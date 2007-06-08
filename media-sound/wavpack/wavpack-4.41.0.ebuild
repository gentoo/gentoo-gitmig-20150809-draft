# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavpack/wavpack-4.41.0.ebuild,v 1.1 2007/06/08 17:34:40 aballier Exp $

DESCRIPTION="WavPack audio compression tools"
HOMEPAGE="http://www.wavpack.com/"
SRC_URI="http://www.wavpack.com/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="mmx"

src_compile() {
	econf $(use_enable mmx) || die "econf failed!"

	emake || die "emake failed!"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README
}
