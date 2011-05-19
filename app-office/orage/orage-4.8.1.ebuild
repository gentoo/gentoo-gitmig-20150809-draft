# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/orage/orage-4.8.1.ebuild,v 1.8 2011/05/19 21:52:12 ssuominen Exp $

EAPI=4
inherit flag-o-matic xfconf

DESCRIPTION="Xfce's calendar suite (with panel plug-in)"
HOMEPAGE="http://www.xfce.org/projects/orage/"
SRC_URI="mirror://xfce/src/apps/${PN}/4.8/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="berkdb dbus debug libnotify +xfce_plugins_clock"

RDEPEND=">=dev-libs/libical-0.43
	dev-libs/popt
	>=x11-libs/gtk+-2.10:2
	berkdb? ( >=sys-libs/db-4 )
	dbus? ( >=dev-libs/dbus-glib-0.88 )
	libnotify? ( >=x11-libs/libnotify-0.4.5 )
	xfce_plugins_clock? ( >=xfce-base/xfce4-panel-4.8 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	append-flags -I/usr/include/libical

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
