# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-otr/gaim-otr-2.0.1.ebuild,v 1.4 2005/07/21 04:57:20 rizzo Exp $

inherit flag-o-matic eutils debug

DESCRIPTION="(OTR) Messaging allows you to have private conversations over instant messaging"
HOMEPAGE="http://www.cypherpunks.ca/otr/"
SRC_URI="http://www.cypherpunks.ca/otr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE=""

DEPEND=">=net-libs/libotr-2.0.1
	>=net-im/gaim-1.1.0"

src_compile() {
	strip-flags
	replace-flags -O? -O2

	emake -j1 || die "Make failed"
}

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc COPYING Changelog README
}
