# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/juk/juk-1.1.ebuild,v 1.3 2004/03/01 05:37:14 eradicator Exp $

inherit kde-base
need-kde 3.1 # see its website - it says it really needs >=3.1

newdepend ">=media-libs/id3lib-3.8
	    >=kde-base/kdemultimedia-3.1"

IUSE=""
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="Jukebox and music manager for the KDE desktop"
SRC_URI="http://developer.kde.org/~wheeler/files/src/${P}.tar.gz"
HOMEPAGE="http://www.slackorama.net/oss/juk/"
