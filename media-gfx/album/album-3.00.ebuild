# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/album/album-3.00.ebuild,v 1.2 2004/08/04 21:00:02 mholzer Exp $

DESCRIPTION="HTML photo album generator"
HOMEPAGE="http://MarginalHacks.com/Hacks/album/"
SRC_URI="http://marginalhacks.com/bin/album.versions/${P}.tar.gz"

LICENSE="marginalhacks"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="dev-lang/perl
	media-gfx/imagemagick
	media-gfx/jhead"

src_install() {
	dobin album
	doman album.1
	dohtml Documentation.html
	dodoc License.txt
}

pkg_postinst() {
	einfo "For some optional themes please browse:"
	einfo "http://MarginalHacks.com/Hacks/album/Themes/"
	einfo
	einfo "For some optional tools please browse:"
	einfo "http://MarginalHacks.com/Hacks/album/tools/"
}
