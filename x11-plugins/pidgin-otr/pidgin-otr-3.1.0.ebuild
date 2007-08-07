# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/pidgin-otr/pidgin-otr-3.1.0.ebuild,v 1.1 2007/08/07 02:17:22 tester Exp $

inherit flag-o-matic eutils autotools

DESCRIPTION="(OTR) Messaging allows you to have private conversations over instant messaging"
HOMEPAGE="http://www.cypherpunks.ca/otr/"
SRC_URI="http://www.cypherpunks.ca/otr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=net-libs/libotr-3.1.0
	net-im/pidgin"

src_compile() {
	strip-flags
	replace-flags -O? -O2

	econf || die "econf failed"
	emake -j1 || die "Make failed"
}

src_install() {
	emake -j1 install DESTDIR="${D}" || die "Install failed"
	dodoc COPYING ChangeLog README
}
