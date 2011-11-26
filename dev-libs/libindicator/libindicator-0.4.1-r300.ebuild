# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libindicator/libindicator-0.4.1-r300.ebuild,v 1.1 2011/11/26 16:25:05 ssuominen Exp $

EAPI=4

DESCRIPTION="A set of symbols and convience functions that all indicators would like to use"
HOMEPAGE="http://launchpad.net/libindicator"
SRC_URI="http://launchpad.net/${PN}/${PV%.*}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.22
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	!<${CATEGORY}/${PN}-0.4.1-r201"

src_prepare() {
	sed -i -e 's:-Werror::' {libindicator,tests,tools}/Makefile.{am,in} || die
}

src_configure() {
	econf \
		--disable-static \
		--with-gtk=3
}

src_install() {
	emake -j1 DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog
	rm -f "${ED}"usr/lib*/*.la
}
