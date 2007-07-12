# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/ufraw/ufraw-0.11.ebuild,v 1.2 2007/07/12 04:08:47 mr_bones_ Exp $

inherit eutils autotools fdo-mime gnome2-utils

DESCRIPTION="RAW Image format viewer and GIMP plugin"
HOMEPAGE="http://ufraw.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gimp exif gnome"

DEPEND=">=x11-libs/gtk+-2.4.0
	gimp? ( >=media-gfx/gimp-2.0 )
	exif? ( >=media-libs/libexif-0.6.13
	        media-gfx/exiv2 )
	gnome? ( gnome-base/gconf )
	media-libs/jpeg
	media-libs/tiff
	>=media-libs/lcms-1.13"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch ${FILESDIR}/${PN}-cflags.patch
	eautoreconf || die "failed running autoreconf"
}

src_compile() {
	econf `use_enable gimp` \
		`use_with exif libexif` \
		`use_with exif exiv2` \
		`use_enable gnome mime` || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
}

pkg_postinst() {
	if use gnome ; then
		fdo-mime_mime_database_update
		gnome2_gconf_install
		fdo-mime_desktop_database_update
	fi
}
