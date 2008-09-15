# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/shunit2/shunit2-2.1.4.ebuild,v 1.1 2008/09/15 23:01:28 dberkholz Exp $

DESCRIPTION="shUnit2 is a unit-test framework for Bourne-based shell scripts."
HOMEPAGE="http://code.google.com/p/shunit2/wiki/ProjectInfo"
SRC_URI="http://shunit2.googlecode.com/files/${P}.tgz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc test"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-lang/perl
	net-misc/curl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/^__SHUNIT_SHELL_FLAGS/s:u::' src/shell/shunit2
}

src_compile() {
	local myconf="build"
	use doc && myconf="${myconf} docs"
	use test && myconf="${myconf} test"

	emake ${myconf} || die
}

src_install() {
	if use doc; then
		for DOC in build/{docbook/*,shunit2.html,shunit2_shelldoc.xml}; do
			dodoc ${DOC} || die
			rm ${DOC}
		done
	fi

	dodoc doc/*.txt || die

	insinto /usr/share/${PN}
	doins build/* || die
}
