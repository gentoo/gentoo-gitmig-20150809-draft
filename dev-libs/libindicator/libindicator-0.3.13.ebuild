# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicator/libindicator-0.3.13.ebuild,v 1.1 2010/09/18 18:53:14 eva Exp $

EAPI=2

inherit autotools base eutils

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

DOCS="AUTHORS"

src_prepare() {
	sed -i \
		-e 's:-Werror::' \
		{libindicator,tests,tools}/Makefile.am || die

	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-static
}
