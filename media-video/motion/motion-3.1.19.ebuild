# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/motion/motion-3.1.19.ebuild,v 1.4 2005/05/19 21:53:24 luckyduck Exp $

DESCRIPTION="Motion is a video surveillance system"
HOMEPAGE="http://www.lavrsen.dk/twiki/bin/view/Motion/WebHome"
SRC_URI="mirror://sourceforge/motion/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~amd64"
IUSE=""

DEPEND="media-video/ffmpeg
	dev-libs/xmlrpc-c"

src_install() {
	make install DESTDIR=${D} || die "make install failed"
}
