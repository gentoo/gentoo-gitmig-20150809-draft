# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/harfbuzz/harfbuzz-9999.ebuild,v 1.2 2011/10/06 14:48:14 scarabeus Exp $

EAPI=4

EGIT_REPO_URI="git://anongit.freedesktop.org/harfbuzz"
[[ ${PV} == 9999 ]] && SCM_ECLASS="git-2 autotools"
inherit base ${SCM_ECLASS}

DESCRIPTION="An OpenType text shaping engine"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/HarfBuzz"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
[[ ${PV} == 9999 ]] || KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="cairo +glib graphite +icu static-libs +truetype"

RDEPEND="
	cairo? ( x11-libs/cairo )
	glib? ( dev-libs/glib:2 )
	graphite? ( media-gfx/graphite2 )
	icu? ( dev-libs/icu )
	truetype? ( media-libs/freetype:2 )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	dev-util/pkgconfig
	dev-util/ragel
"

PATCHES=(
	"${FILESDIR}/${PN}-automagicness.patch"
)

src_prepare() {
	base_src_prepare
	libtoolize --force --copy
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with cairo) \
		$(use_with glib) \
		$(use_with graphite) \
		$(use_with icu) \
		$(use_with truetype freetype)
}

src_install() {
	default
	find "${ED}" -name '*.la' -exec rm -f {} +
}
