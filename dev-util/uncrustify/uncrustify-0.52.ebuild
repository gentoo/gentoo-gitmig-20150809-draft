# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/uncrustify/uncrustify-0.52.ebuild,v 1.1 2009/10/01 17:43:44 grobian Exp $

DESCRIPTION="C/C++/C#/D/Java/Pawn code indenter and beautifier"
HOMEPAGE="http://uncrustify.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

DEPEND="test? ( dev-lang/python )"
RDEPEND=""

src_test() {
	cd tests
	./run_tests.py || die "tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS BUGS NEWS README || die "dodoc failed"
}
