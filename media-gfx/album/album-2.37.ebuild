# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/album/album-2.37.ebuild,v 1.6 2004/07/14 17:12:11 agriffis Exp $

DESCRIPTION="HTML photo album generator"
HOMEPAGE="http://MarginalHacks.com/Hacks/album/"
SRC_URI="http://MarginalHacks.com/bin/album.tar.gz
	http://MarginalHacks.com/bin/album.versions/mpeg2decode.patch-1.tar.gz"

LICENSE="marginalhacks"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}
	media-gfx/imagemagick
	media-video/mpeg2vidcodec"

S=${WORKDIR}

src_install() {
	dobin album
	dodir /usr/share/${PN}
	cp -R Themes/* ${D}/usr/share/${PN}/
	dodoc mpeg2dec/{README,PATCH}
	dohtml Documentation.html
}

pkg_postinst() {
	einfo "For some optional themes please browse:"
	einfo "http://MarginalHacks.com/Hacks/album/Themes/"
	einfo
	einfo "For some optional tools please browse:"
	einfo "http://MarginalHacks.com/Hacks/album/tools/"
}
