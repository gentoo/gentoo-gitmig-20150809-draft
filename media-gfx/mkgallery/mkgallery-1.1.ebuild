# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/mkgallery/mkgallery-1.1.ebuild,v 1.3 2003/09/29 23:45:30 todd Exp $

DESCRIPTION="Creates thumbnails and a HTML index file for a directory of jpg files"
HOMEPAGE="http://mkgallery.sourceforge.net/"
SRC_URI="http://mkgallery.sourceforge.net/${PN}-${PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="x86 sparc"
SLOT="0"

DEPEND="media-gfx/imagemagick"

src_install() {
	dobin mkgallery
	dodoc BUGS README THANKS TODO
}
