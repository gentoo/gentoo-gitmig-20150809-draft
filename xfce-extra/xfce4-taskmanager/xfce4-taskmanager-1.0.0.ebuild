# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-taskmanager/xfce4-taskmanager-1.0.0.ebuild,v 1.6 2010/11/05 19:21:26 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Task Manager"
HOMEPAGE="http://goodies.xfce.org/projects/applications/xfce4-taskmanager"
SRC_URI="mirror://xfce/src/apps/${PN}/1.0/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=x11-libs/cairo-1.5
	>=x11-libs/gtk+-2.12:2
	x11-libs/libwnck"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	XFCONF=(
		--disable-dependency-tracking
		--enable-wnck
		$(xfconf_use_debug)
		)

	DOCS="AUTHORS ChangeLog NEWS README THANKS"
}
