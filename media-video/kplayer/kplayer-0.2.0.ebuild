# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kplayer/kplayer-0.2.0.ebuild,v 1.1 2003/04/12 02:07:08 hannes Exp $

inherit kde-base
need-kde 3
DESCRIPTION="KPlayer is a KDE media player based on mplayer."
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"
HOMEPAGE="http://www.sourceforge.net/projects/kplayer"

LICENSE="GPL-2"
KEYWORDS="~x86"

IUSE=""
newdepend "media-video/mplayer"
S="${WORKDIR}/${PN}-0.2"
