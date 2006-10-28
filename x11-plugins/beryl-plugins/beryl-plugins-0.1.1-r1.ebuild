# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/beryl-plugins/beryl-plugins-0.1.1-r1.ebuild,v 1.1 2006/10/28 20:24:25 tsunam Exp $

inherit autotools flag-o-matic

DESCRIPTION="Beryl Window Decorator Plugins"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://distfiles.gentoo-xeffects.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="dbus"

DEPEND="x11-wm/beryl-core
	>=gnome-base/librsvg-2.14.0"

PDEPEND="dbus? ( x11-plugins/beryl-dbus )"

S="${WORKDIR}/${PN}"
MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	#filter ldflags to follow upstream
	filter-ldflags -znow -z,now -Wl,-znow -Wl,-z,now
	eautoreconf || die "eautoreconf failed"
	glib-gettextize --copy --force || die

	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
