# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/robodoc/robodoc-4.99.8.ebuild,v 1.1 2005/05/29 04:45:27 usata Exp $

DESCRIPTION="Automating Software Documentation"
HOMEPAGE="http://www.xs4all.nl/~rfsber/Robo/robodoc.html"
SRC_URI="http://www.xs4all.nl/~rfsber/Robo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-text/xmlto"

src_install() {
	make DESTDIR=${D} docdir=/usr/share/doc/${PF} install || die "make install failed"
	rm -rf ${D}/usr/share/man/manh

	for doc in `find Examples Headers -type f`; do
		docinto ${doc%/*}
		dodoc   ${doc}
	done

	prepalldocs
}
