# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/xmltoman/xmltoman-0.3.ebuild,v 1.2 2006/01/06 11:56:53 weeve Exp $

DESCRIPTION="Simple scripts for converting xml to groff or html"
HOMEPAGE="none"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${P/-/_}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/XML-Parser"
RDEPEND="${DEPEND}"

src_install() {
	make install DESTDIR="${D}" PREFIX="/usr" || die "make install failed"

	dodoc README
	doman xmltoman.1 xmlmantohtml.1
}
