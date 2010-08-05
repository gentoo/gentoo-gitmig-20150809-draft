# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-datetime-plugin/xfce4-datetime-plugin-0.6.1.ebuild,v 1.3 2010/08/05 23:05:49 ssuominen Exp $

EAPI=2
inherit xfconf

DESCRIPTION="Panel plugin displaying date, time and small calendar"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.6/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/xfce4-panel-4.3.99.2
	>=xfce-base/libxfce4util-4.3.99.2
	>=xfce-base/libxfcegui4-4.3.99.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	DOCS="AUTHORS ChangeLog NEWS THANKS"
	XFCONF="--disable-dependency-tracking
		--disable-static
		$(xfconf_use_debug)"
}
