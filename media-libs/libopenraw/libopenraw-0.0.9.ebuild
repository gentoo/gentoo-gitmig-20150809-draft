# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libopenraw/libopenraw-0.0.9.ebuild,v 1.2 2011/12/19 08:59:01 nirbheek Exp $

EAPI=4

DESCRIPTION="A decoding library for RAW image formats"
HOMEPAGE="http://libopenraw.freedesktop.org/wiki/"
SRC_URI="http://${PN}.freedesktop.org/download/${P}.tar.bz2"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk static-libs test"

RDEPEND="virtual/jpeg
	dev-libs/libxml2
	gtk? (
		>=dev-libs/glib-2
		>=x11-libs/gdk-pixbuf-2.24.0:2
		)"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.35
	dev-util/pkgconfig
	test? ( net-misc/curl )"

DOCS=( AUTHORS ChangeLog NEWS README TODO )

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_enable gtk gnome)
}

src_install() {
	default
	find "${ED}"usr -name '*.la' -exec rm -f {} +
}
