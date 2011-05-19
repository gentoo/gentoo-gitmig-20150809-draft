# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-places-plugin/xfce4-places-plugin-1.2.0.ebuild,v 1.16 2011/05/19 21:34:05 ssuominen Exp $

EAPI=4
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Places menu plug-in for panel, like GNOME's"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-places-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/1.2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/libxfcegui4-4.8
	xfce-extra/thunar-vfs
	>=xfce-base/exo-0.6
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-exo.patch )
	XFCONF=( $(xfconf_use_debug) )
	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}
