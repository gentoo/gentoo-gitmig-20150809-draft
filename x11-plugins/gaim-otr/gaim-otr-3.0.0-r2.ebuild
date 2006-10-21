# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-otr/gaim-otr-3.0.0-r2.ebuild,v 1.1 2006/10/21 13:29:43 gothgirl Exp $

inherit flag-o-matic eutils debug

DESCRIPTION="(OTR) Messaging allows you to have private conversations over instant messaging"
HOMEPAGE="http://www.cypherpunks.ca/otr/"
SRC_URI="http://www.cypherpunks.ca/otr/${P}.tar.gz http://www.cypherpunks.ca/otr/gaim2b2-otr.diff"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=net-libs/libotr-3.0.0
	>=net-im/gaim-1.5.0"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/gaim2b2-otr.diff
	epatch ${FILESDIR}/gaim-2b4-otr.patch
}

src_compile() {
	strip-flags
	replace-flags -O? -O2

	econf || die "econf failed"
	emake -j1 || die "Make failed"
}

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc COPYING ChangeLog README
}
