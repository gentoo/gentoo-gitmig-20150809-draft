# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfdesktop/xfdesktop-4.7.0.ebuild,v 1.2 2010/09/06 13:40:27 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Desktop manager for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/xfdesktop"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.7/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
# This is because xfdesktop doesn't ship menu files anymore. Unreleased garcon is required, which has them.
KEYWORDS=""
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="debug thunar"

RDEPEND="x11-libs/libX11
	x11-libs/libSM
	>=x11-libs/libwnck-2.12
	>=dev-libs/glib-2.18:2
	>=x11-libs/gtk+-2.14:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfce4ui-4.7
	>=xfce-base/garcon-0.1.1
	>=xfce-base/xfconf-4.6
	thunar? ( >=xfce-base/exo-0.5
		xfce-extra/thunar-vfs
		dev-libs/dbus-glib )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig"

pkg_setup() {
	XFCONF="--docdir=${EPREFIX}/usr/share/doc/${PF}
		--disable-dependency-tracking
		--disable-static
		$(use_enable thunar file-icons)
		--disable-thunarx
		$(use_enable thunar exo)
		$(xfconf_use_debug)"

	DOCS="AUTHORS ChangeLog NEWS README TODO"
}
