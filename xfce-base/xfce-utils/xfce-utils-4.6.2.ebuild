# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.6.2.ebuild,v 1.5 2010/07/09 16:41:29 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Collection of utils for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/xfce-utils/"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.6/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="dbus debug +lock"

RDEPEND="x11-apps/xrdb
	x11-libs/libX11
	>=dev-libs/glib-2.6:2
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/xfconf-4.6
	dbus? ( >=dev-libs/dbus-glib-0.70 )
	lock? ( || ( x11-misc/xscreensaver
		gnome-extra/gnome-screensaver
		x11-misc/xlockmore ) )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(use_enable dbus)
		$(use_enable debug)
		--with-vendor-info=Gentoo
		--with-xsession-prefix=${EPREFIX}/usr"
	DOCS="AUTHORS ChangeLog NEWS README"
}

src_install() {
	xfconf_src_install
	insinto /usr/share/xfce4
	doins "${FILESDIR}"/Gentoo || die "doins failed"
	echo startxfce4 > "${T}"/Xfce4
	exeinto /etc/X11/Sessions
	doexe "${T}"/Xfce4 || die "doexe failed"
}

pkg_postinst() {
	elog "Run Xfce4 from your favourite Display Manager by using"
	elog "XSESSION=\"Xfce4\" in /etc/rc.conf"
}
