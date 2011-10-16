# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/tumbler/tumbler-0.1.22.ebuild,v 1.3 2011/10/16 05:24:34 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A thumbnail service for the filemanager of Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/thunar/"
SRC_URI="mirror://xfce/src/apps/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux"
IUSE="debug ffmpeg gstreamer jpeg pdf"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.88
	>=dev-libs/glib-2.16:2
	media-libs/freetype:2
	>=media-libs/libpng-1.4
	>=sys-apps/dbus-1.4.1
	|| ( x11-libs/gdk-pixbuf:2 ( <x11-libs/gtk+-2.22:2 >=x11-libs/gtk+-2.14:2 ) )
	ffmpeg? ( >=media-video/ffmpegthumbnailer-2 )
	gstreamer? ( media-libs/gstreamer:0.10
		media-libs/gst-plugins-base:0.10 )
	jpeg? ( virtual/jpeg )
	pdf? ( >=app-text/poppler-0.12.4[cairo] )"
RDEPEND="${COMMON_DEPEND}
	>=xfce-base/thunar-1.2"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF=(
		--disable-static
		$(use_enable jpeg jpeg-thumbnailer)
		$(use_enable ffmpeg ffmpeg-thumbnailer)
		$(use_enable pdf poppler-thumbnailer)
		$(use_enable gstreamer gstreamer-thumbnailer)
		$(xfconf_use_debug)
		--with-html-dir="${EPREFIX}"/usr/share/doc/${PF}/html
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}
