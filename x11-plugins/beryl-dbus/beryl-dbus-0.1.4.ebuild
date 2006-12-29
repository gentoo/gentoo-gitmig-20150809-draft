# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/beryl-dbus/beryl-dbus-0.1.4.ebuild,v 1.2 2006/12/29 18:50:21 tsunam Exp $

inherit flag-o-matic gnome2

DESCRIPTION="Beryl Window Decorator Dbus Plugin"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://releases.beryl-project.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="=x11-plugins/beryl-plugins-${PV}
	sys-apps/dbus"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	gnome2_src_unpack
	intltoolize --force || die "intltool failed"
}

src_compile() {
	filter-ldflags -znow -z,now -Wl,-znow -Wl,-z,now
	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
