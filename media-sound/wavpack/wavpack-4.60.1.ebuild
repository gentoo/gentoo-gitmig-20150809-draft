# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/wavpack/wavpack-4.60.1.ebuild,v 1.2 2011/04/26 20:09:08 scarabeus Exp $

EAPI=4
inherit libtool

DESCRIPTION="WavPack audio compression tools"
HOMEPAGE="http://www.wavpack.com"
SRC_URI="http://www.wavpack.com/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="mmx"

DOCS=( ChangeLog README )

src_prepare() {
	elibtoolize
}

src_configure() {
	econf --disable-static \
		$(use_enable mmx)
}

src_install() {
	default
	find "${ED}" -name '*.la' -delete
}
