# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.7.2.ebuild,v 1.1 2003/02/18 03:13:16 hannes Exp $

inherit kde-base
need-kde 3.1


DESCRIPTION="MPlayer frontend for KDE"
HOMEPAGE="http://www.xs4all.nl/~jjvrieze/kmplayer.html"
SRC_URI="http://www.xs4all.nl/~jjvrieze/${P}.tar.bz2"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="~x86 ~ppc"

DEPEND=">=kde-base/kdemultimedia-3.1_rc3
	>=media-video/mplayer-0.90_rc1"

S=${WORKDIR}/${PN}
