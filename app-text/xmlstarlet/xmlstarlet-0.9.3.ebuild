# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmlstarlet/xmlstarlet-0.9.3.ebuild,v 1.1 2004/09/03 14:33:13 usata Exp $

DESCRIPTION="XMLStarlet is a set of XML command line utilities"
HOMEPAGE="http://xmlstar.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmlstar/${P}.tar.gz"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~x86"

IUSE=""
DEPEND="dev-libs/libxml2
	dev-libs/libxslt"

src_compile() {
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
