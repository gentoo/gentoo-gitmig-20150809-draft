# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/ctrlproxy/ctrlproxy-3.0.5.ebuild,v 1.4 2008/04/15 13:37:19 drac Exp $

DESCRIPTION="IRC proxy with multiserver and multiclient support"
HOMEPAGE="http://ctrlproxy.vernstok.nl/"
SRC_URI="http://ctrlproxy.vernstok.nl/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ~ppc x86"
IUSE="ssl"

RESTRICT="test"

RDEPEND=">=dev-libs/glib-2
	ssl? ( net-libs/gnutls )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install install-doc || die "emake install failed"
}
