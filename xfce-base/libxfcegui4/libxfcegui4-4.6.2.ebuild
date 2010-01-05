# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/libxfcegui4/libxfcegui4-4.6.2.ebuild,v 1.1 2010/01/05 17:12:56 darkside Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Unified widgets library for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/libraries"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.6/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="debug glade startup-notification"

RDEPEND="gnome-base/libglade
	x11-libs/libSM
	x11-libs/libX11
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/xfconf-4.6
	glade? ( dev-util/glade:3 )
	startup-notification? ( x11-libs/startup-notification )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		--disable-static
		$(use_enable startup-notification)
		$(use_enable glade gladeui)
		$(use_enable debug)"
	DOCS="AUTHORS ChangeLog NEWS"
}
