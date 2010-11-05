# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-cpugraph-plugin/xfce4-cpugraph-plugin-1.0.0.ebuild,v 1.4 2010/11/05 16:56:21 jer Exp $

EAPI=2
inherit xfconf

DESCRIPTION="CPU load panel plugin"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.0/${P}.tar.bz2"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=xfce-base/libxfcegui4-4.3.20
	>=xfce-base/xfce4-panel-4.3.20
	>=x11-libs/gtk+-2.12:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(xfconf_use_debug)"
	DOCS="AUTHORS ChangeLog NEWS README"
}
