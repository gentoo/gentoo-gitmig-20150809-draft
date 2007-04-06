# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayerthumbs/mplayerthumbs-0.5b.ebuild,v 1.1 2007/04/06 21:00:49 genstef Exp $

inherit kde

DESCRIPTION="A Thumbnail Generator for Video Files on Konqueror."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=41180"
SRC_URI="http://xoomer.alice.it/rockman81/${P}.tar.bz2"
LICENSE="GPL-2"

RESTRICT=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="( || ( kde-base/konqueror kde-base/kdebase ) )
		( || ( media-video/mplayer media-video/mplayer-bin ) )"

need-kde 3.3
