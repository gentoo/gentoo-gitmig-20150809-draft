# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayerthumbs/mplayerthumbs-1.1.ebuild,v 1.2 2009/02/10 14:09:43 scarabeus Exp $

EAPI="2"

KDE_MINIMAL="4.2"
inherit kde4-base

DESCRIPTION="A Thumbnail Generator for Video Files on Konqueror."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=41180"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/41180-${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| (
		>=kde-base/dolphin-${KDE_MINIMAL}
		>=kde-base/konqueror-${KDE_MINIMAL}
	)
	|| (
		media-video/mplayer
		media-video/mplayer-bin
		)
"
RDEPEND="${DEPEND}"

src_prepare() {
	kde4-base_src_prepare

	sed -i \
		-e "s:\${KDE4_KDECORE_LIBS}:\${KDE4_KDECORE_LIBS} \${KDE4_KIO_LIBS}:g" \
		"${S}"/src/CMakeLists.txt || die "fixing linkage failed"
}
