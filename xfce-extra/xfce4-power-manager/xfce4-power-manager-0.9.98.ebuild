# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-power-manager/xfce4-power-manager-0.9.98.ebuild,v 1.3 2010/08/11 08:49:52 ssuominen Exp $

EAPI=2
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Power manager for Xfce4"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfce4-power-manager"
SRC_URI="mirror://xfce/src/apps/${PN}/0.9/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug doc networkmanager +plugins +policykit"

COMMON_DEPEND=">=x11-libs/gtk+-2.18:2
	>=dev-libs/glib-2.16:2
	>=dev-libs/dbus-glib-0.70
	>=xfce-base/xfconf-4.6
	>=xfce-base/libxfce4ui-4.7
	>=xfce-base/libxfce4util-4.6
	>=x11-libs/libnotify-0.4.1
	>=x11-libs/libXrandr-1.2
	x11-libs/libX11
	x11-libs/libXext
	sys-fs/udisks
	sys-power/upower
	plugins? ( >=xfce-base/xfce4-panel-4.6 )
	policykit? ( >=sys-auth/polkit-0.91 )
	!<xfce-base/xfce-utils-4.6.2-r1"
RDEPEND="${COMMON_DEPEND}
	networkmanager? ( net-misc/networkmanager )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext
	x11-proto/xproto
	doc? ( dev-libs/libxslt )"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-fix_polkit_switch.patch )

	XFCONF="--disable-dependency-tracking
		$(use_enable policykit polkit)
		--disable-hal
		--enable-dpms
		$(use_enable networkmanager network-manager)
		$(use_enable plugins panel-plugins)
		$(use_enable doc xsltproc)
		$(xfconf_use_debug)"

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}

src_prepare() {
	# http://bugzilla.xfce.org/show_bug.cgi?id=6630
	sed -i \
		-e '/libxfcegui4/d' \
		panel-plugins/brightness/brightness-button.c || die

	xfconf_src_prepare
}
