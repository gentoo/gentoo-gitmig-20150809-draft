# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/juk/juk-1.0_p1.ebuild,v 1.2 2003/07/12 20:30:52 aliz Exp $

inherit kde-base
need-kde 3.1 # see its website - it says it really needs >=3.1

newdepend ">=media-libs/id3lib-3.8
	    >=kde-base/kdemultimedia-3.1"

IUSE=""
LICENSE="GPL-2"
KEYWORDS="x86"
DESCRIPTION="Jukebox and music manager for the KDE desktop"
SRC_URI="http://www.slackorama.net/oss/${PN}/${P//_p/-}.tar.gz"
HOMEPAGE="http://www.slackorama.net/oss/juk/"
S="${WORKDIR}/juk-1.0"
