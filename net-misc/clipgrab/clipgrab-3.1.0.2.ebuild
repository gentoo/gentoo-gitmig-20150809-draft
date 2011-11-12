# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clipgrab/clipgrab-3.1.0.2.ebuild,v 1.1 2011/11/12 01:23:36 xmw Exp $

EAPI=4

inherit qt4-r2 eutils

DESCRIPTION="Download from various internet video services like Youtube etc."
HOMEPAGE="http://clipgrab.de/en"
SRC_URI="http://${PN}.de/download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
	virtual/ffmpeg"

PATCHES=(
	"${FILESDIR}/obey.patch"
)

src_install() {
	dobin ${PN}

	newicon icon.png ${PN}.png
	make_desktop_entry clipgrab Clipgrab "" "Qt;Video;AudioVideo;"
}
