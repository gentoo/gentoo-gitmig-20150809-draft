# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-systemload-plugin/xfce4-systemload-plugin-0.4.2-r1.ebuild,v 1.4 2010/07/09 17:01:09 ssuominen Exp $

EAUTORECONF=yes
EINTLTOOLIZE=yes
EAPI=2
inherit xfconf

DESCRIPTION="System load monitor panel plugin"
HOMEPAGE="http://www.xfce.org/"
SRC_URI="http://www.us.xfce.org/archive/src/panel-plugins/xfce4-systemload-plugin/0.4/xfce4-systemload-plugin-0.4.2.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ppc64 ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="debug"

RDEPEND=">=x11-libs/gtk+-2.6:2
	>=xfce-base/xfce4-panel-4.3.99.1
	>=xfce-base/libxfcegui4-4.3.99.1
	>=xfce-base/libxfce4util-4.3.99.1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

pkg_setup() {
	PATCHES=( "${FILESDIR}/${P}-libtool.patch"
		"${FILESDIR}/${P}-fix-tooltip-gtk2.12.patch" )
	DOCS="AUTHORS ChangeLog NEWS README"
	XFCONF="--disable-dependency-tracking
		$(use_enable debug)"
}

src_prepare() {
	sed -i -e "/^AC_INIT/s/systemload_version()/systemload_version/" \
		configure.in || die "sed failed"
	xfconf_src_prepare
}
