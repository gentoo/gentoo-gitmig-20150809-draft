# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kmplayer/kmplayer-0.8.3a.ebuild,v 1.5 2005/05/22 16:25:31 dertobi123 Exp $

inherit kde

MY_P="${P/_rc/rc}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="MPlayer frontend for KDE"
HOMEPAGE="http://www.xs4all.nl/~jjvrieze/kmplayer.html"
SRC_URI="http://www.xs4all.nl/~jjvrieze/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc amd64"
IUSE="xine"

DEPEND=">=media-video/mplayer-0.90
	xine? ( >=media-libs/xine-lib-1_beta12 )"
need-kde 3.1