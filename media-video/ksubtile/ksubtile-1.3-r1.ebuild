# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ksubtile/ksubtile-1.3-r1.ebuild,v 1.1 2009/02/15 17:33:17 carlo Exp $

ARTS_REQUIRED="never"

inherit kde

DESCRIPTION="Utility to edit subtitles in SRT format."
HOMEPAGE="http://ksubtile.sourceforge.net/"
SRC_URI="mirror://sourceforge/ksubtile/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="media-video/mplayer"

need-kde 3.5

PATCHES=(
	"${FILESDIR}/ksubtile-1.3-desktop-file.diff"
	)

src_unpack() {
	kde_src_unpack
	rm -f "${S}"/configure
}
