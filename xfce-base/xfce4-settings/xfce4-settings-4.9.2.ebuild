# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-settings/xfce4-settings-4.9.2.ebuild,v 1.1 2012/02/20 20:51:37 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="Configuration system for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/xfce4-settings/"
SRC_URI="mirror://xfce/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug libcanberra libnotify +xklavier"

RDEPEND=">=dev-libs/dbus-glib-0.92
	>=dev-libs/glib-2.24
	media-libs/fontconfig
	>=x11-libs/gtk+-2.20:2
	x11-libs/libX11
	>=x11-libs/libXcursor-1.1
	>=x11-libs/libXi-1.3
	>=x11-libs/libXrandr-1.2
	>=xfce-base/exo-0.7.1
	>=xfce-base/libxfce4ui-4.9
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfconf-4.8
	libcanberra? ( >=media-libs/libcanberra-0.25[sound] )
	libnotify? ( >=x11-libs/libnotify-0.7 )
	xklavier? ( >=x11-libs/libxklavier-5 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	>=x11-proto/inputproto-1.4
	x11-proto/xproto"

pkg_setup() {
	XFCONF=(
		$(use_enable libnotify)
		$(use_enable xklavier libxklavier)
		$(use_enable libcanberra sound-settings)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS TODO )
}

src_prepare() {
	local theme=Hicolor
	has_version x11-themes/tango-icon-theme && theme=Tango
	has_version x11-themes/gnome-icon-theme && theme=GNOME
	has_version x11-themes/faenza-icon-theme && theme=Faenza
	sed -i -e "/IconThemeName/s:Rodent:${theme}:" xfsettingsd/xsettings.xml || die

	xfconf_src_prepare
}
