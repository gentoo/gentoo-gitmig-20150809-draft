# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce-utils/xfce-utils-4.7.4.ebuild,v 1.1 2011/01/02 15:26:58 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Xfce's utilities"
HOMEPAGE="http://www.xfce.org/projects/xfce-utils/"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.7/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="dbus debug +lock"

COMMON_DEPEND="x11-libs/libX11
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfce4ui-4.7
	>=xfce-base/xfconf-4.6
	dbus? ( >=dev-libs/dbus-glib-0.70 )"
RDEPEND="${COMMON_DEPEND}
	x11-apps/xrdb
	x11-misc/xdg-user-dirs
	lock? ( || ( x11-misc/xscreensaver
		gnome-extra/gnome-screensaver
		x11-misc/xlockmore
		x11-misc/slock ) )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=(
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
		--disable-dependency-tracking
		--disable-xfconf-migration
		$(use_enable dbus)
		$(xfconf_use_debug)
		--with-vendor-info=Gentoo
		--with-xsession-prefix="${EPREFIX}"/usr
		)

	DOCS="AUTHORS ChangeLog NEWS"
}

src_install() {
	xfconf_src_install

	rm -f "${ED}"/usr/share/applications/xfhelp4.desktop

	insinto /usr/share/xfce4
	doins "${FILESDIR}"/Gentoo || die

	echo startxfce4 > "${T}"/Xfce4
	exeinto /etc/X11/Sessions
	doexe "${T}"/Xfce4 || die
}
