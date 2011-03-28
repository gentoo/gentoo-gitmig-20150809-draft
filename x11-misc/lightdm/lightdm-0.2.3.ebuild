# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lightdm/lightdm-0.2.3.ebuild,v 1.2 2011/03/28 22:08:28 ssuominen Exp $

EAPI=4
inherit pam

DESCRIPTION="A lightweight display manager"
HOMEPAGE="http://launchpad.net/lightdm"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz
	http://people.ubuntu.com/~robert-ancell/${PN}/releases/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+introspection qt4"

RDEPEND=">=dev-libs/dbus-glib-0.88
	net-libs/webkit-gtk:2
	virtual/pam
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXdmcp
	x11-libs/libxklavier
	introspection? ( dev-libs/gobject-introspection )
	qt4? ( x11-libs/qt-gui:4 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

src_configure() {
	local default=gnome
	has_version xfce-base/xfce4-meta && default=xfce

	econf \
		--localstatedir=/var \
		--disable-static \
		--disable-dependency-tracking \
		$(use_enable introspection) \
		$(use_enable qt4 liblightdm-qt) \
		--with-default-session=${default} \
		--with-html-dir=/usr/share/doc/${PF}/html
}

src_install() {
	default

	find "${D}" -name '*.la' -exec rm -f {} +

	pamd_mimic system-local-login lightdm auth account session
}
