# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/beryl-dbus/beryl-dbus-0.1.1-r1.ebuild,v 1.1 2006/10/28 20:27:10 tsunam Exp $

inherit autotools flag-o-matic

DESCRIPTION="Beryl Window Decorator Dbus Plugin"
HOMEPAGE="http://beryl-project.org"
SRC_URI="http://distfiles.gentoo-xeffects.org/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="x11-plugins/beryl-plugins
	sys-apps/dbus"

S="${WORKDIR}/${PN}"
MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	filter-ldflags -znow -z,now -Wl,-znow -Wl,-z,now
	eautoreconf || die "eautoreconf failed"
	glib-gettextize --copy --force || die

	econf || die "econf failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
