# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mplayerthumbs/mplayerthumbs-0.5b-r1.ebuild,v 1.1 2009/02/15 17:37:07 carlo Exp $

EAPI="1"

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="A thumbnail generator for video files on Konqueror."
HOMEPAGE="http://www.kde-look.org/content/show.php?content=41180"
SRC_URI="http://xoomer.alice.it/rockman81/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( kde-base/konqueror:3.5 kde-base/kdebase:3.5 )"
RDEPEND="${DEPEND}
	media-video/mplayer"

need-kde 3.5

PATCHES=( "${FILESDIR}/${P}-gcc43.patch" )
