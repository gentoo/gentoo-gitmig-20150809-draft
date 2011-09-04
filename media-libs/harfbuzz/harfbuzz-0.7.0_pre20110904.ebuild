# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/harfbuzz/harfbuzz-0.7.0_pre20110904.ebuild,v 1.2 2011/09/04 11:27:15 scarabeus Exp $

EAPI=4

DESCRIPTION="An OpenType text shaping engine"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/HarfBuzz"
SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-libs/glib:2
	dev-libs/icu
	media-libs/freetype:2
	x11-libs/cairo
"
DEPEND="${RDEPEND}
	dev-util/ragel
	dev-util/pkgconfig
"

src_configure() {
	# this packge needs build system update because
	# all the deps are automagic
	econf \
		--disable-static
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
