# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kplayer/kplayer-0.1.0.ebuild,v 1.3 2003/07/12 21:12:43 aliz Exp $

inherit kde-base
need-kde 3
DESCRIPTION="KPlayer is a KDE media player based on mplayer."
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"
HOMEPAGE="http://www.sourceforge.net/projects/kplayer"

LICENSE="GPL-2"
KEYWORDS="x86"

IUSE=""
newdepend "media-video/mplayer"
