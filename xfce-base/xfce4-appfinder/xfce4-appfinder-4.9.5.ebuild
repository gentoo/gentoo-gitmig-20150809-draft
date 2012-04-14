# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfce4-appfinder/xfce4-appfinder-4.9.5.ebuild,v 1.1 2012/04/14 09:09:39 ssuominen Exp $

EAPI=4
inherit xfconf

DESCRIPTION="A tool to find and launch installed applications for the Xfce desktop environment"
HOMEPAGE="http://www.xfce.org/projects/"
SRC_URI="mirror://xfce/src/xfce/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="debug"

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.24
	>=x11-libs/gtk+-2.20:2
	>=xfce-base/garcon-0.1.12
	>=xfce-base/libxfce4util-4.9.1
	>=xfce-base/libxfce4ui-4.9.2
	>=xfce-base/xfconf-4.9.1
	!xfce-base/xfce-utils"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	XFCONF=( $(xfconf_use_debug) )
	DOCS=( AUTHORS ChangeLog NEWS )
}
