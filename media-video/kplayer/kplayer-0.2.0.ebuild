# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kplayer/kplayer-0.2.0.ebuild,v 1.5 2004/07/18 16:11:46 carlo Exp $

inherit kde

S="${WORKDIR}/${PN}-0.2"

DESCRIPTION="KPlayer is a KDE media player based on mplayer."
HOMEPAGE="http://www.sourceforge.net/projects/kplayer"
SRC_URI="mirror://sourceforge/kplayer/${P}-src.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="media-video/mplayer"
RDEPEND="media-video/mplayer"
need-kde 3