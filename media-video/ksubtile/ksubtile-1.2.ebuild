# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ksubtile/ksubtile-1.2.ebuild,v 1.3 2009/11/11 13:00:33 ssuominen Exp $

ARTS_REQUIRED=never
inherit kde

DESCRIPTION="Utility to edit subtitles in SRT format."
HOMEPAGE="http://ksubtile.sourceforge.net/"
SRC_URI="mirror://sourceforge/ksubtile/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="media-video/mplayer"

need-kde 3
