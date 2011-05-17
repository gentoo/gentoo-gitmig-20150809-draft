# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wbar/wbar-2.2.1.ebuild,v 1.1 2011/05/17 10:54:41 xarthisius Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A fast, lightweight quick launch bar."
HOMEPAGE="http://code.google.com/p/wbar/"
SRC_URI="http://wbar.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk"

RDEPEND="media-libs/imlib2
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
	dev-util/intltool"

src_prepare() {
	if ! use gtk; then
		# Remove wbar-config from default cfg.
		sed -i -e '5,8d' \
			etc/wbar.cfg.in || die "Removing wbar-config from cfg"
	fi
	sed -i -e '/Werror/d' src/Makefile.am || die
	sed -i configure.ac -e "s/imlib2/& x11/" || die #367549
	eautoreconf
}

src_configure() {
	econf --bindir=/usr/bin $(use_enable gtk wbar-config)
}
