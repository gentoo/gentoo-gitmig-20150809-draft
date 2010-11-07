# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/tumbler/tumbler-0.1.4.ebuild,v 1.1 2010/11/07 14:05:07 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="A D-Bus service for applications to request thumbnails"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/apps/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug ffmpeg jpeg pdf"

RDEPEND=">=dev-libs/glib-2.16:2
	>=dev-libs/dbus-glib-0.72
	>=sys-apps/dbus-1
	>=media-libs/libpng-1.4
	|| ( x11-libs/gdk-pixbuf:2 ( <x11-libs/gtk+-2.22:2 >=x11-libs/gtk+-2.14:2 ) )
	media-libs/freetype:2
	ffmpeg? ( >=media-video/ffmpegthumbnailer-2 )
	jpeg? ( virtual/jpeg )
	pdf? ( >=app-text/poppler-0.12.4[cairo] )
	!<xfce-extra/thunar-thumbnailers-4.7.0"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		--disable-static
		$(use_enable jpeg jpeg-thumbnailer)
		$(use_enable ffmpeg ffmpeg-thumbnailer)
		$(use_enable pdf poppler-thumbnailer)
		$(xfconf_use_debug)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}
