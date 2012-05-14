# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wbar/wbar-2.3.0.ebuild,v 1.1 2012/05/14 13:27:01 hasufell Exp $

EAPI=4

DESCRIPTION="A fast, lightweight quick launch bar"
HOMEPAGE="http://code.google.com/p/wbar/"
SRC_URI="http://wbar.googlecode.com/files/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="media-libs/imlib2[X]
	x11-libs/libX11
	gtk? ( dev-libs/atk
		dev-libs/glib:2
		dev-libs/libxml2
		gnome-base/libglade
		media-libs/fontconfig
		media-libs/freetype
		media-libs/libpng
		x11-libs/cairo
		x11-libs/gdk-pixbuf
		x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

src_prepare() {
	if ! use gtk; then
		# Remove wbar-config from default cfg.
		sed \
			-e '5,8d' \
			-i etc/wbar.cfg.in || die
	fi
}

src_configure() {
	econf \
		$(use_enable gtk wbar-config)
}
