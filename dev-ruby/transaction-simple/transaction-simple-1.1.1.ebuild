# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/transaction-simple/transaction-simple-1.1.1.ebuild,v 1.3 2005/08/15 14:10:59 citizen428 Exp $

inherit ruby

DESCRIPTION="Provides transaction support at the object level"
HOMEPAGE="http://www.halostatue.ca/ruby/Transaction__Simple.html"
SRC_URI="http://www.halostatue.ca/files/${P}.tar.gz"
LICENSE="MIT"

USE_RUBY="ruby18 ruby19"
KEYWORDS="~ppc x86"

IUSE=""

src_compile() {
	return
}

src_install() {
	local sitelibdir
	sitelibdir=`${RUBY} -rrbconfig -e 'puts Config::CONFIG["sitelibdir"]'`
	insinto "$sitelibdir/transaction"
	doins lib/transaction/simple.rb
	erubydoc
	dodoc Readme Changelog
}

src_test() {
	einfo
	einfo "To test this software, read /usr/share/doc/${PF}/Readme.gz"
	einfo
}
