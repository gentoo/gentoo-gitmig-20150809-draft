# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libopenraw/libopenraw-0.0.8-r1.ebuild,v 1.1 2011/09/15 10:47:35 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A decoding library for RAW image formats"
HOMEPAGE="http://libopenraw.freedesktop.org"
SRC_URI="http://${PN}.freedesktop.org/download/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk static-libs test"

RDEPEND="virtual/jpeg
	dev-libs/libxml2
	gtk? ( >=x11-libs/gdk-pixbuf-2.24.0:2 )"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.35
	dev-util/pkgconfig
	test? ( net-misc/curl )"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix_gdk-pixbuf_path.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable gtk gnome)
}

src_install() {
	default
	find "${D}" -name '*.la' -exec rm -f {} +
}
