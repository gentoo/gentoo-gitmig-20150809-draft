# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-privacy-please/pidgin-privacy-please-0.6.4.ebuild,v 1.2 2011/03/21 19:54:19 angelos Exp $

EAPI=2

inherit autotools

DESCRIPTION="pidgin plugin to stop spammers from annoying you"
HOMEPAGE="http://code.google.com/p/pidgin-privacy-please/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="linguas_de"

RDEPEND="<net-im/pidgin-3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	sed -e 's: -Wall -g3::' -i configure.ac || die
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" ALL_LINGUAS="${LANGS}" install || die
	dodoc AUTHORS ChangeLog NEWS README || die
}
