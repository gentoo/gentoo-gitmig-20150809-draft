# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-time-out-plugin/xfce4-time-out-plugin-0.1.1.ebuild,v 1.3 2010/09/06 20:36:11 ssuominen Exp $

EAPI=3
inherit xfconf

DESCRIPTION="Panel plugin to take a break from computer work"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.1/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.8:2
	>=xfce-base/xfce4-panel-4.3.99.2
	>=xfce-base/libxfce4util-4.3.99.2
	>=xfce-base/libxfcegui4-4.3.99.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	XFCONF="--disable-dependency-tracking
		$(xfconf_use_debug)"
	DOCS="AUTHORS ChangeLog NEWS README THANKS TODO"
}
