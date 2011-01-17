# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-power-manager/xfce4-power-manager-1.0.3.ebuild,v 1.3 2011/01/17 15:11:27 xarthisius Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Power manager for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfce4-power-manager"
SRC_URI="mirror://xfce/src/apps/${PN}/1.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="debug kernel_linux networkmanager policykit +xfce_plugins_brightness"

COMMON_DEPEND=">=x11-libs/gtk+-2.18:2
	>=dev-libs/glib-2.16:2
	>=dev-libs/dbus-glib-0.88
	>=xfce-base/xfconf-4.8
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=x11-libs/libnotify-0.4.1
	>=x11-libs/libXrandr-1.2
	x11-libs/libX11
	x11-libs/libXext
	sys-power/upower
	kernel_linux? ( sys-fs/udisks )
	xfce_plugins_brightness? ( >=xfce-base/xfce4-panel-4.8 )
	policykit? ( >=sys-auth/polkit-0.91 )"
RDEPEND="${COMMON_DEPEND}
	networkmanager? ( net-misc/networkmanager )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	x11-proto/xproto"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable policykit polkit)
		--enable-dpms
		$(use_enable networkmanager network-manager)
		$(use_enable xfce_plugins_brightness panel-plugins)
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_install() {
	xfconf_src_install \
		docdir=/usr/share/doc/${PF}/html \
		imagesdir=/usr/share/doc/${PF}/html/images
}
