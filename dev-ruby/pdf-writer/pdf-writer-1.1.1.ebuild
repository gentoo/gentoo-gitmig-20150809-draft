# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pdf-writer/pdf-writer-1.1.1.ebuild,v 1.1 2005/08/15 14:18:45 citizen428 Exp $

inherit ruby gems

DESCRIPTION="PDF::Writer for Ruby"
HOMEPAGE="http://rubyforge.org/projects/ruby-pdf/"
SRC_URI="http://rubyforge.org/frs/download.php/5068/${P}.gem"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

USE_RUBY="ruby18"
DEPEND=">=dev-ruby/color-tools-1.0.0
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

