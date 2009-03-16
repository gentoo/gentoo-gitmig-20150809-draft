# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayerthumbs/mplayerthumbs-1.2.ebuild,v 1.3 2009/03/16 19:22:45 scarabeus Exp $

EAPI="2"

inherit kde4-base

DESCRIPTION="A Thumbnail Generator for Video Files on Konqueror."
HOMEPAGE="http://www.kde-apps.org/content/show.php?content=41180"
SRC_URI="http://www.kde-apps.org/CONTENT/content-files/41180-${P}.tar.gz"
LICENSE="GPL-2"

SLOT="1"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="!kdeprefix? ( !media-video/mplayerthumbs:0 )
	|| (
		>=kde-base/dolphin-${KDE_MINIMAL}[kdeprefix=]
		>=kde-base/konqueror-${KDE_MINIMAL}[kdeprefix=]
	)
	|| (
		media-video/mplayer
		media-video/mplayer-bin
		)
"
RDEPEND="${DEPEND}"
