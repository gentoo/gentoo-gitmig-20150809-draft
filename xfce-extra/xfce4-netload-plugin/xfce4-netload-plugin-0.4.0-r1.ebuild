# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-netload-plugin/xfce4-netload-plugin-0.4.0-r1.ebuild,v 1.10 2010/08/09 11:04:06 ssuominen Exp $

EAPI=2
EAUTORECONF=yes
EINTLTOOLIZE=yes
inherit xfconf

DESCRIPTION="Netload plugin for Xfce4 panel"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/0.4/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=xfce-base/libxfcegui4-4.3.20
	>=xfce-base/xfce4-panel-4.3.20"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	PATCHES=(
		"${FILESDIR}"/${P}-asneeded.patch
		"${FILESDIR}"/${P}-link_to_libxfcegui4.patch
		"${FILESDIR}"/${P}-fix-tooltips-gtk2.16.patch
		)
	XFCONF="--disable-dependency-tracking
		$(xfconf_use_debug)"
	DOCS="AUTHORS ChangeLog README"
}

src_prepare() {
	sed -i \
		-e '/^AC_INIT/s/netload_version()/netload_version/' \
		configure.ac || die
	xfconf_src_prepare
}
