# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/brasero/brasero-0.6.0.ebuild,v 1.4 2007/08/24 19:57:49 dertobi123 Exp $

inherit gnome2 gnome.org

DESCRIPTION="Brasero (aka Bonfire) is yet another application to burn CD/DVD for the gnome desktop."
HOMEPAGE="http://www.gnome.org/projects/brasero"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE="beagle dvd gdl libburn libnotify totem nls"

RDEPEND=">=x11-libs/gtk+-2.10
	>=gnome-base/libgnome-2.10
	>=gnome-base/libgnomeui-2.10
	>=gnome-base/gnome-vfs-2.14.2
	>=media-libs/gstreamer-0.10.6
	>=media-libs/gst-plugins-base-0.10.6
	>=media-plugins/gst-plugins-ffmpeg-0.10
	>=gnome-extra/nautilus-cd-burner-2.16.0
	>=dev-libs/libxml2-2.6
	>=sys-apps/hal-0.5.5
	app-cdr/cdrdao
	virtual/cdrtools
	gnome-base/gnome-mount
	dvd? ( media-libs/libdvdcss )
	gdl? ( >=dev-libs/gdl-0.6 )
	totem? ( >=media-video/totem-1.4.2 )
	beagle? ( >=app-misc/beagle-0.2.5 )
	libnotify? ( >=x11-libs/libnotify-0.3.0 )
	libburn? ( >=dev-libs/libburn-0.3.4
		>=dev-libs/libisofs-0.2.4 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool"

G2CONF="${G2CONF} \
	$(use_enable totem playlist) \
	$(use_enable beagle search) \
	$(use_enable libburn) \
	$(use_enable libnotify) \
	--disable-caches"

DOCS="AUTHORS ChangeLog NEWS README TODO.tasks"
USE_DESTDIR="1"

src_install() {
	gnome2_src_install
	use nls || rm -rf ${D}/usr/share/locale
}

pkg_postinst() {
	gnome2_pkg_postinst
	elog
	elog "For a best experience you should have a Linux Kernel >= 2.6.13"
	elog "to enable system features such as Extended Attributes and inotify."
	elog
}
