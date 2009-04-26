# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/policykit-gnome/policykit-gnome-0.9.2.ebuild,v 1.5 2009/04/26 14:48:30 armin76 Exp $

inherit gnome2

MY_PN="PolicyKit-gnome"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="PolicyKit policies and configurations for the GNOME desktop"
HOMEPAGE="http://hal.freedesktop.org/docs/PolicyKit"
SRC_URI="http://hal.freedesktop.org/releases/${MY_P}.tar.bz2"

LICENSE="LGPL-2 GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~sh ~sparc ~x86"
IUSE="doc examples"

RDEPEND=">=x11-libs/gtk+-2.13.6
	>=gnome-base/gconf-2.8
	>=dev-libs/dbus-glib-0.71
	>=sys-auth/policykit-0.9"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.35.0
	>=app-text/scrollkeeper-0.3.14
	>=app-text/gnome-doc-utils-0.12
	doc? ( >=dev-util/gtk-doc-1.3 )"

DOCS="AUTHORS ChangeLog HACKING NEWS TODO"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	G2CONF="${G2CONF} $(use_enable examples)"
}
