# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/recoverjpeg/recoverjpeg-1.1.4.ebuild,v 1.3 2009/10/29 14:27:07 maekke Exp $

DESCRIPTION="Recover JPEG pictures from a possibly corrupted disk image"
HOMEPAGE="http://www.rfc1149.net/devel/recoverjpeg"
SRC_URI="http://www.rfc1149.net/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="minimal"

DEPEND=""
RDEPEND="!minimal? (
		media-gfx/imagemagick
		media-gfx/exif
		dev-lang/python
	)"

src_install() {
	if use minimal; then
		dobin ${PN} || die "cannot install ${PN}"
		doman ${PN}.1 || die "cannot install manpages"
	else
		emake DESTDIR="${D}" install || die "emake install failed"
	fi
	dodoc README
}
