# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/albumart/albumart-1.6.4.ebuild,v 1.5 2008/05/05 13:50:40 armin76 Exp $

inherit distutils eutils qt3

DESCRIPTION="Album Cover Art Downloader"
HOMEPAGE="http://unrealvoodoo.org/hiteck/projects/albumart"
SRC_URI="http://muksuluuri.ath.cx/~skyostil/projects/${PN}/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

DEPEND="dev-python/PyQt
	dev-python/imaging"

src_install() {
	distutils_src_install
	rm -rf "${D}"/usr/share/{doc/albumart,applnk}
	make_desktop_entry ${PN}-qt "Album Cover Art Downloader" ${PN}
}
