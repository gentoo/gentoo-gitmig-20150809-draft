# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.6.3a.ebuild,v 1.1 2003/01/18 19:48:48 hannes Exp $

inherit kde-base
need-kde 3.1


DESCRIPTION="MPlayer frontend for KDE"
HOMEPAGE="http://www.xs4all.nl/~jjvrieze/kmplayer.html"
SRC_URI="http://www.xs4all.nl/~jjvrieze/${P}.tar.bz2"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86"

DEPEND=">=kde-base/kdemultimedia-3.1_rc3
	>=media-video/mplayer-0.90_rc1"

S=${WORKDIR}/${PN}
