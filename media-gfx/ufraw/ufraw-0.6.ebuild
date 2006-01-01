# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ufraw/ufraw-0.6.ebuild,v 1.2 2006/01/01 20:51:03 metalgod Exp $

DESCRIPTION="RAW Image format viewer and GIMP plugin"
HOMEPAGE="http://ufraw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gimp exif" # jpeg tiff"


#should but not
DEPEND=">=x11-libs/gtk+-2.4.0
	gimp? ( >=media-gfx/gimp-2.0 )
	exif? ( >=media-libs/libexif-0.6.12 )
	media-libs/jpeg
	media-libs/tiff
	>=media-libs/lcms-1.13"

src_compile() {
	econf `use_enable gimp` \
		`use_enable exif` || die "configure failed"
	emake || die "emake failed"
}


src_install() {
	make DESTDIR="${D}" install || die
}
