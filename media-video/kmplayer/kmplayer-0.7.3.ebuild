# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.7.3.ebuild,v 1.2 2003/04/26 11:53:10 hannes Exp $

inherit kde-base
need-kde 3.1


DESCRIPTION="MPlayer frontend for KDE"
HOMEPAGE="http://www.xs4all.nl/~jjvrieze/kmplayer.html"
SRC_URI="http://www.xs4all.nl/~jjvrieze/${P}.tar.bz2"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="x86 ~ppc"

newdepend ">=media-video/mplayer-0.90_rc2"

S=${WORKDIR}/${PN}
