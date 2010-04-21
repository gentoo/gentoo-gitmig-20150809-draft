# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/osmo/osmo-0.2.8.ebuild,v 1.3 2010/04/21 18:22:25 ssuominen Exp $

EAPI=2
inherit flag-o-matic

DESCRIPTION="A handy personal organizer"
HOMEPAGE="http://clayo.org/osmo/"
SRC_URI="mirror://sourceforge/${PN}-pim/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12:2
	dev-libs/libtar
	dev-libs/libxml2
	dev-libs/libgringotts
	>=dev-libs/libical-0.33
	app-text/gtkspell
	x11-libs/libnotify"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	append-flags -I/usr/include/libical

	econf \
		--disable-dependency-tracking \
		--without-libsyncml
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TRANSLATORS
	use syncml && dodoc README.syncml
}
