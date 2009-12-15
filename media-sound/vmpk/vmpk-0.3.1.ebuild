# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vmpk/vmpk-0.3.1.ebuild,v 1.1 2009/12/15 22:39:07 aballier Exp $

inherit cmake-utils eutils

DESCRIPTION="Virtual MIDI Piano Keyboard"
HOMEPAGE="http://vmpk.sourceforge.net/"
SRC_URI="mirror://sourceforge/vmpk/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="x11-libs/qt-core
	x11-libs/qt-gui
	media-libs/alsa-lib"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_install() {
	cmake-utils_src_install
	rm -rf "${D}/usr/share/doc/packages"
}
