# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/geeqie/geeqie-1.0-r1.ebuild,v 1.4 2010/06/24 08:40:58 hwoarang Exp $

EAPI=2

DESCRIPTION="A lightweight GTK image viewer forked from GQview"
HOMEPAGE="http://geeqie.sourceforge.net/"
SRC_URI="mirror://sourceforge/geeqie/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc exif lcms lirc xmp"

RDEPEND=">=x11-libs/gtk+-2.4.0
	virtual/libintl
	doc? ( app-text/gnome-doc-utils )
	lcms? ( =media-libs/lcms-1* )
	lirc? ( app-misc/lirc )
	xmp? ( >=media-gfx/exiv2-0.17[xmp] )
	!xmp? ( exif? ( >=media-gfx/exiv2-0.17 ) )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--with-readmedir=/usr/share/doc/${PF} \
		$(use_enable exif exiv2) \
		$(use_enable lcms) \
		$(use_enable lirc) \
		|| die "econf faild"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}/usr/share/doc/${MY_P}/COPYING"
}

pkg_postinst() {
	elog "Some plugins may require additional packages"
	elog "- Image rotate plugin: media-gfx/fbida (JPEG), media-gfx/imagemagick (TIFF/PNG)"
	elog "- RAW images plugin: media-gfx/ufraw"
}
