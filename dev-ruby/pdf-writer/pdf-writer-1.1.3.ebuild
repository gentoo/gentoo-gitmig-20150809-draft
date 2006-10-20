# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pdf-writer/pdf-writer-1.1.3.ebuild,v 1.4 2006/10/20 21:53:55 agriffis Exp $

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
	einfo "This package was installed using a 'gem'."
	einfo "If you are intending to write code which"
	einfo "requires ${PN}, you will need to"
	einfo
	einfo "require 'rubygems'"
	einfo
	einfo "before requiring '${PN}'."
}

