# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/geeqie/geeqie-1.0_beta2.ebuild,v 1.1 2009/07/02 19:03:28 voyageur Exp $

EAPI=2

MY_P="${P/_/}"

DESCRIPTION="A lightweight GTK image viewer forked from GQview"
HOMEPAGE="http://geeqie.sourceforge.net/"
SRC_URI="mirror://sourceforge/geeqie/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="exif lcms lirc xmp"

S="${WORKDIR}/${MY_P}"

RDEPEND=">=x11-libs/gtk+-2.4.0
	xmp? ( >=media-gfx/exiv2-0.17[xmp] )
	!xmp? ( exif? ( >=media-gfx/exiv2-0.17 ) )
	lcms? ( media-libs/lcms )
	lirc? ( app-misc/lirc )
	virtual/libintl"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable exif exiv2) \
		$(use_enable lcms) \
		$(use_enable lirc) \
		|| die "econf faild"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}/usr/share/doc/${MY_P}/COPYING"
}
