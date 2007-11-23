# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/policykit-gnome/policykit-gnome-0.6.ebuild,v 1.1 2007/11/23 20:01:10 compnerd Exp $

inherit gnome2

MY_PN="PolicyKit-gnome"

DESCRIPTION="PolicyKit policies and configurations for the GNOME desktop"
HOMEPAGE="http://hal.freedesktop.org/docs/PolicyKit"
SRC_URI="http://hal.freedesktop.org/releases/${MY_PN}-${PV}.tar.bz2"

LICENSE="|| ( LGPL-2 GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}-${PV}"

RDEPEND=">=dev-libs/dbus-glib-0.71
	>=x11-libs/gtk+-2.10
	>=gnome-base/libgnome-2.14
	>=gnome-base/libgnomeui-2.14
	>=sys-auth/policykit-0.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=app-text/scrollkeeper-0.3.14
	>=dev-util/intltool-0.35.0
	sys-devel/gettext"

pkg_setup()
{
		G2CONF="--disable-examples"
}
