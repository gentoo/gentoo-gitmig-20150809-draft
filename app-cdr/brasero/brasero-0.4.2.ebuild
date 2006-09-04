# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/brasero/brasero-0.4.2.ebuild,v 1.2 2006/09/04 02:32:54 metalgod Exp $

inherit gnome2

DESCRIPTION="Brasero (aka Bonfire) is yet another application to burn CD/DVD for the gnome desktop."
HOMEPAGE="http://perso.wanadoo.fr/bonfire/"
SRC_URI="mirror://sourceforge/bonfire/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="beagle gdl libnotify totem nls"

RDEPEND=">=x11-libs/gtk+-2.8
	>=gnome-base/libgnome-2.14
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/gnome-vfs-2.14.2
	>=media-libs/gstreamer-0.10.6
	>=media-libs/gst-plugins-base-0.10.6
	>=gnome-extra/nautilus-cd-burner-2.14.2
	>=dev-libs/libxml2-2.6
	>=sys-apps/hal-0.5.5
	app-cdr/cdrdao
	gdl? ( >=dev-libs/gdl-0.6 )
	totem? ( >=media-video/totem-1.4.2 )
	beagle? ( >=app-misc/beagle-0.2.5 )
	libnotify? ( >=x11-libs/libnotify-0.3 )"

DEPEND="${RDEPEND}
	!app-cdr/bonfire
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool"

G2CONF="${G2CONF} \
	$(use_enable totem playlist) \
	$(use_enable beagle search) \
	$(use_enable libnotify) \
	--disable-caches"

DOCS="AUTHORS ChangeLog NEWS README TODO.tasks"
USE_DESTDIR="1"

src_install() {
	gnome2_src_install
	use nls || rm -rf ${D}/usr/share/locale
}

pkg_postinst() {
	einfo
	einfo "For a best experience you should have a Linux Kernel >= 2.6.13"
	einfo "to enable system features such as Extended Attributes and inotify."
	einfo
}
