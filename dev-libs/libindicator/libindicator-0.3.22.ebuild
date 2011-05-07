# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicator/libindicator-0.3.22.ebuild,v 1.1 2011/05/07 20:55:30 angelos Exp $

EAPI=4
inherit autotools

DESCRIPTION="A set of symbols and convience functions that all indicators would like to use"
HOMEPAGE="http://launchpad.net/libindicator/"
SRC_URI="http://launchpad.net/${PN}/0.3/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.18:2
	>=dev-libs/glib-2.22:2
	>=dev-libs/dbus-glib-0.76
	!<gnome-extra/indicator-applet-0.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	sed -i \
		-e 's:-Werror::' \
		{libindicator,tests,tools}/Makefile.am || die

	eautoreconf
}

src_configure() {
	# TODO gtk+3 support
	econf \
		--disable-static \
		--with-gtk=2
}

src_install() {
	emake DESTDIR="${D}" -j1 install
	dodoc AUTHORS ChangeLog
	find "${ED}" -type f -name "*.la" -exec rm -rf {} + || die
}
