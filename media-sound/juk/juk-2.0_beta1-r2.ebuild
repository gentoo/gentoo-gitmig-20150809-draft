# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/juk/juk-2.0_beta1-r2.ebuild,v 1.3 2004/02/15 14:45:18 dholm Exp $

inherit kde
need-kde 3.1 # see its website - it says it really needs >=3.1

newdepend ">=media-libs/id3lib-3.8
	   >=kde-base/kdemultimedia-3.1"

MY_P="juk-1.95"
S=${WORKDIR}/${MY_P}

IUSE=""
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"
DESCRIPTION="Jukebox and music manager for the KDE desktop"
SRC_URI="http://developer.kde.org/~wheeler/files/src/${MY_P}a.tar.gz"
HOMEPAGE="http://www.slackorama.net/oss/juk/"

src_unpack() {
	kde_src_unpack
}

src_compile() {
	econf || die
	emake || die
}
