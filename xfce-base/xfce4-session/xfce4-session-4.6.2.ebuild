# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.6.2.ebuild,v 1.3 2010/06/30 15:59:51 fauli Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Session manager for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/xfce4-session/"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.6/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="debug fortune gnome gnome-keyring profile"

RDEPEND="gnome-base/libglade
	>=dev-libs/dbus-glib-0.73
	x11-libs/libX11
	x11-libs/libSM
	>=x11-libs/libwnck-2.12
	x11-apps/iceauth
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfconf-4.6
	>=xfce-base/xfce-utils-4.6
	gnome? ( gnome-base/gconf )
	gnome-keyring? ( gnome-base/gnome-keyring )
	fortune? ( games-misc/fortune-mod )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		--disable-static
		$(use_enable gnome)
		$(use_enable gnome-keyring libgnome-keyring)
		$(use_enable debug)
		$(use_enable profile profiling)
		$(use_enable profile gcov)"
	DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"
}

src_install() {
	xfconf_src_install

	if ! use fortune; then
		# Wipe away unusable xfce4-tips
		rm -Rf "${D}"/usr/share/xfce4/tips
		rm -f "${D}"/usr/bin/xfce4-tips \
			"${D}"/usr/lib/debug/usr/bin/xfce4-tips.debug \
			"${D}"/etc/xdg/autostart/xfce4-tips-autostart.desktop
		rmdir -p "${D}"/etc/xdg/autostart
	fi
}
