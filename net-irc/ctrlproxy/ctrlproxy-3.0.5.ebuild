# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ctrlproxy/ctrlproxy-3.0.5.ebuild,v 1.1 2007/12/13 21:43:18 armin76 Exp $

inherit flag-o-matic

DESCRIPTION="IRC proxy with multiserver and multiclient support"
HOMEPAGE="http://ctrlproxy.vernstok.nl/"
SRC_URI="http://ctrlproxy.vernstok.nl/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~ia64 ~ppc ~x86"
IUSE="ssl"
RESTRICT="test"

DEPEND=">=dev-libs/glib-2
	dev-libs/popt
	dev-libs/libxml2
	dev-libs/libpcre
	dev-util/pkgconfig
	ssl? ( net-libs/gnutls )"

src_compile() {
	# hack alert
	append-flags -fPIC

	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "emake install failed"
}
