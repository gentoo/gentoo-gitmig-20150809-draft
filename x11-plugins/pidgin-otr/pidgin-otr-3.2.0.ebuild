# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-otr/pidgin-otr-3.2.0.ebuild,v 1.2 2009/08/16 09:02:49 betelgeuse Exp $

EAPI="2"

inherit flag-o-matic eutils autotools

DESCRIPTION="(OTR) Messaging allows you to have private conversations over instant messaging"
HOMEPAGE="http://www.cypherpunks.ca/otr/"
SRC_URI="http://www.cypherpunks.ca/otr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=net-libs/libotr-3.2.0
	>=x11-libs/gtk+-2
	net-im/pidgin[gtk]"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	strip-flags
	replace-flags -O? -O2

	econf || die "econf failed"
}

src_compile() {
	emake -j1 || die "Make failed"
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die "Install failed"
	dodoc ChangeLog README || die
}
