# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pdf-writer/pdf-writer-1.1.3.ebuild,v 1.6 2007/07/11 05:23:08 mr_bones_ Exp $

inherit ruby gems

DESCRIPTION="PDF::Writer for Ruby"
HOMEPAGE="http://rubyforge.org/projects/ruby-pdf/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="ia64 x86"
IUSE=""

USE_RUBY="ruby18"
DEPEND=">=dev-ruby/color-tools-1.3.0
	>=dev-ruby/transaction-simple-1.3.0"

pkg_postinst() {
	elog "This package was installed using a 'gem'."
	elog "If you are intending to write code which"
	elog "requires ${PN}, you will need to"
	elog
	elog "require 'rubygems'"
	elog
	elog "before requiring '${PN}'."
}
