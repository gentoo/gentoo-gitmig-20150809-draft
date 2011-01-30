# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-verve-plugin/xfce4-verve-plugin-0.3.6.ebuild,v 1.6 2011/01/30 00:04:57 ssuominen Exp $

EAPI=3
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Command line panel plugin"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.3/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="dbus debug"

RDEPEND=">=xfce-base/exo-0.3.1.3
	>=xfce-base/xfce4-panel-4.4
	>=xfce-base/libxfce4util-4.4
	>=xfce-base/libxfcegui4-4.4
	>=dev-libs/libpcre-5
	dbus? ( >=dev-libs/dbus-glib-0.88 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	PATCHES=(
		"${FILESDIR}"/${P}-exo.patch
		"${FILESDIR}"/${P}-link_to_libxfcegui4.patch
		)
	XFCONF=(
		--disable-dependency-tracking
		$(use_enable dbus)
		$(xfconf_use_debug)
		)
	DOCS="AUTHORS ChangeLog README THANKS TODO"
}
