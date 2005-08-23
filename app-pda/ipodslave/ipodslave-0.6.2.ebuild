# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/ipodslave/ipodslave-0.6.2.ebuild,v 1.5 2005/08/23 21:12:07 malc Exp $

inherit kde eutils

IUSE=""
DESCRIPTION="This ioslave enables KIO aware linux apps to access the Music stored on an Apple iPod. It further allows you to organize playlists and uploading tracks."
HOMEPAGE="http://kpod.sourceforge.net/ipodslave/"
SRC_URI="mirror://sourceforge/kpod/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"

DEPEND="media-libs/id3lib"

need-kde 3.2

src_unpack() {
	kde_src_unpack

	epatch ${FILESDIR}/${P}-udev.patch
}
