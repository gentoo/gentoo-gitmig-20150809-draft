# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlstarlet/xmlstarlet-0.9.5.ebuild,v 1.1 2004/11/30 03:02:50 usata Exp $

inherit flag-o-matic

DESCRIPTION="XMLStarlet is a set of XML command line utilities"
HOMEPAGE="http://xmlstar.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmlstar/${P}.tar.gz"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~x86"

IUSE=""
DEPEND=">=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.9
	dev-libs/libgcrypt
	dev-libs/libgpg-error"

src_compile() {
	append-ldflags -lgcrypt
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog NEWS README TODO
	dohtml -r *
}

src_test() {
	cd tests
	sh runTests || die "sh runTests failed."
}
