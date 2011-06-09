# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vmpk/vmpk-0.4.0.ebuild,v 1.1 2011/06/09 18:43:01 aballier Exp $

inherit cmake-utils eutils

DESCRIPTION="Virtual MIDI Piano Keyboard"
HOMEPAGE="http://vmpk.sourceforge.net/"
SRC_URI="mirror://sourceforge/vmpk/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus"

RDEPEND="x11-libs/qt-core
	x11-libs/qt-gui
	x11-libs/qt-svg
	dbus? ( x11-libs/qt-dbus )
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_compile() {
	local mycmakeargs=( "$(cmake-utils_use_enable dbus DBUS)" )
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	rm -rf "${D}/usr/share/doc/packages"
}
