# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/orage/orage-4.8.3.ebuild,v 1.1 2012/01/06 13:05:28 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A time managing application (and panel plug-in) for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/orage/"
SRC_URI="mirror://xfce/src/apps/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="berkdb dbus debug libnotify +xfce_plugins_clock"

RDEPEND=">=dev-libs/libical-0.48
	dev-libs/popt
	>=x11-libs/gtk+-2.10:2
	berkdb? ( >=sys-libs/db-4 )
	dbus? ( >=dev-libs/dbus-glib-0.90 )
	libnotify? ( >=x11-libs/libnotify-0.7 )
	xfce_plugins_clock? ( >=xfce-base/xfce4-panel-4.8 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}/html
		$(use_enable xfce_plugins_clock libxfce4panel)
		$(use_enable dbus)
		$(use_enable libnotify)
		$(use_with berkdb bdb4)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}
