# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/stimg/stimg-0.1.0.ebuild,v 1.6 2005/04/24 03:33:39 hansmi Exp $

IUSE=""

DESCRIPTION="Simple and tiny image loading library"

HOMEPAGE="http:///homepage3.nifty.com/slokar/fb/"
SRC_URI="http://homepage3.nifty.com/slokar/stimg/${P}.tar.gz"

LICENSE="as-is LGPL-2"

SLOT="0"

KEYWORDS="x86 alpha ppc"

DEPEND=">=media-libs/libpng-1.0.12-r2
	>=media-libs/jpeg-6b-r2
	>=media-libs/tiff-3.5.7-r1"

src_install() {
	einstall

	dodoc AUTHORS COPYING{,.imlib2} INSTALL README.ja
}
