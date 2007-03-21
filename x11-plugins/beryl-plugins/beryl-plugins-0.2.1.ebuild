# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/beryl-plugins/beryl-plugins-0.2.1.ebuild,v 1.1 2007/03/21 02:48:42 tsunam Exp $

inherit flag-o-matic

DESCRIPTION="Beryl Window Decorator Plugins"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="dbus"

RDEPEND="~x11-wm/beryl-core-${PV}
	>=gnome-base/librsvg-2.14.0
	dbus? (
		|| ( dev-libs/dbus-glib	( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.36 ) )
	)
	!x11-plugins/beryl-dbus"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.19
	>=sys-devel/gettext-0.15
	>=dev-util/intltool-0.35"

pkg_setup() {
	if ! built_with_use x11-libs/cairo glitz ; then
		elog "Please rebuild cairo with USE=\"glitz\""
		die "x11-libs/cairo missing glitz support"
	fi
}

src_compile() {
	filter-ldflags -znow -z,now
	filter-ldflags -Wl,-znow -Wl,-z,now

	econf $(use_enable dbus) || die "econf failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
