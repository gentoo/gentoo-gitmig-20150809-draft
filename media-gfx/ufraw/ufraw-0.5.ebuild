# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ufraw/ufraw-0.5.ebuild,v 1.1 2005/09/27 16:09:37 lu_zero Exp $

DESCRIPTION="RAW Image format viewer and GIMP plugin"
HOMEPAGE="ufraw.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gimp exif" # jpeg tiff"


#should but not
DEPEND=">=x11-libs/gtk+-2.4.0
		gimp? ( >=media-gfx/gimp-2.0 )
		exif? ( >=media-libs/libexif-0.6.12 )
		media-libs/jpeg
		media-libs/tiff
		>=media-libs/lcms-1.13"

src_compile() {
	myconf=""
	myconf="`use_enable gimp`	\
			`use_enable exif`	\
			"
	econf $myconf || die "configure failed"
	emake || die "emake failed"
}


src_install() {
	make DESTDIR="$D" install || die
}

