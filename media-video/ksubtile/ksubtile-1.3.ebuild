# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ksubtile/ksubtile-1.3.ebuild,v 1.1 2007/11/15 01:34:06 peper Exp $

inherit kde

DESCRIPTION="Utility to edit subtitles in SRT format."
HOMEPAGE="http://ksubtile.sourceforge.net/"
SRC_URI="mirror://sourceforge/ksubtile/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-video/mplayer"

need-kde 3
