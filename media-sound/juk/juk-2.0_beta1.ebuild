# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/juk/juk-2.0_beta1.ebuild,v 1.1 2003/08/26 14:23:26 caleb Exp $

inherit kde-base
need-kde 3.1 # see its website - it says it really needs >=3.1

newdepend ">=media-libs/id3lib-3.8
	   >=kde-base/kdemultimedia-3.1"

MY_P="juk-1.95"
S=${WORKDIR}/${MY_P}

IUSE=""
LICENSE="GPL-2"
KEYWORDS="~x86"
DESCRIPTION="Jukebox and music manager for the KDE desktop"
SRC_URI="http://developer.kde.org/~wheeler/files/src/${MY_P}.tar.gz"
HOMEPAGE="http://www.slackorama.net/oss/juk/"
