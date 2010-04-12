# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vmpk/vmpk-0.3.1.ebuild,v 1.4 2010/04/12 08:21:55 aballier Exp $

inherit cmake-utils eutils

DESCRIPTION="Virtual MIDI Piano Keyboard"
HOMEPAGE="http://vmpk.sourceforge.net/"
SRC_URI="mirror://sourceforge/vmpk/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/qt-core
	x11-libs/qt-gui
	x11-libs/qt-svg
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	app-text/docbook-xsl-stylesheets
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_install() {
	cmake-utils_src_install
	rm -rf "${D}/usr/share/doc/packages"
}
