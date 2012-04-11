# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-session/xfce4-session-4.9.0-r1.ebuild,v 1.2 2012/04/11 12:33:54 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A session manager for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/"
SRC_URI="mirror://xfce/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="consolekit debug gnome-keyring udev"

COMMON_DEPEND=">=dev-libs/dbus-glib-0.98
	x11-apps/iceauth
	x11-libs/libSM
	>=x11-libs/libwnck-2.22:1
	x11-libs/libX11
	>=xfce-base/libxfce4util-4.9
	>=xfce-base/libxfce4ui-4.9
	>=xfce-base/xfconf-4.9
	gnome-keyring? ( >=gnome-base/libgnome-keyring-2.22 )
	!xfce-base/xfce-utils"
RDEPEND="${COMMON_DEPEND}
	x11-apps/xrdb
	x11-misc/xdg-user-dirs
	consolekit? ( || ( sys-auth/consolekit sys-apps/systemd ) )
	udev? ( sys-power/upower )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		$(use_enable gnome-keyring libgnome-keyring)
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS BUGS ChangeLog NEWS README TODO )
}

src_install() {
	xfconf_src_install

	echo startxfce4 > "${T}"/Xfce4
	exeinto /etc/X11/Sessions
	doexe "${T}"/Xfce4
}
