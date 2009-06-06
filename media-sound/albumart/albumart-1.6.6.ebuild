# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/albumart/albumart-1.6.6.ebuild,v 1.3 2009/06/06 17:03:57 nixnut Exp $

inherit distutils eutils qt3

DESCRIPTION="Album Cover Art Downloader"
HOMEPAGE="http://unrealvoodoo.org/hiteck/projects/albumart"
SRC_URI="http://muksuluuri.unrealvoodoo.org/~skyostil/projects/albumart/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE=""

RDEPEND="dev-python/PyQt
	dev-python/imaging"
DEPEND="${RDEPEND}"

src_install() {
	distutils_src_install
	rm -rf "${D}"/usr/share/{doc/albumart,applnk}
	make_desktop_entry ${PN}-qt "Album Cover Art Downloader" ${PN}
}
