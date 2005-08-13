# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/album/album-3.07.ebuild,v 1.1 2005/08/13 20:49:55 vanquirius Exp $

DESCRIPTION="HTML photo album generator"
HOMEPAGE="http://MarginalHacks.com/Hacks/album/"
SRC_URI="http://marginalhacks.com/bin/album.versions/${P}.tar.gz"

LICENSE="marginalhacks"
SLOT="0"
KEYWORDS="~x86 ~ppc ~ppc64"
IUSE="ffmpeg"

DEPEND="virtual/libc"
RDEPEND="dev-lang/perl
	media-gfx/imagemagick
	media-gfx/jhead
	ffmpeg ( media-video/ffmpeg )"

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
