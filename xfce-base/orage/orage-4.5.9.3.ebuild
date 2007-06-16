# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/orage/orage-4.5.9.3.ebuild,v 1.1 2007/06/16 17:22:05 drac Exp $

inherit xfce44

XFCE_VERSION="4.4.1"
xfce44

DESCRIPTION="Calendar"
HOMEPAGE="http://www.kolumbus.fi/~w408237/orage"
SRC_URI="http://www.kolumbus.fi/~w408237/${PN}/${P}.tar.bz2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="dbus debug"

S="${WORKDIR}"/${P}-svn

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	>=xfce-base/libxfce4mcs-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	>=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION}
	dbus? ( dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	!xfce-extra/xfcalendar"

DOCS="AUTHORS ChangeLog NEWS README"

XFCE_CONFIG="${XFCE_CONFIG} $(use_enable dbus)"

pkg_postinst() {
	xfce44_pkg_postinst
	elog
	elog "There is no migration support from 4.4 to 4.5 so you need to copy	Orage files manually."
	elog
}
