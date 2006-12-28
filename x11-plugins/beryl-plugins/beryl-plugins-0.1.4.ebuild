# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/beryl-plugins/beryl-plugins-0.1.4.ebuild,v 1.1 2006/12/28 19:47:51 tsunam Exp $

inherit flag-o-matic

DESCRIPTION="Beryl Window Decorator Plugins"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="dbus"

DEPEND="=x11-wm/beryl-core-${PV}
	>=gnome-base/librsvg-2.14.0"

PDEPEND="dbus? ( =x11-plugins/beryl-dbus-${PV} )"

MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	#filter ldflags to follow upstream
	filter-ldflags -znow -z,now -Wl,-znow -Wl,-z,now

	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
