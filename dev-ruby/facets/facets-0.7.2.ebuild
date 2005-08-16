# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/facets/facets-0.7.2.ebuild,v 1.1 2005/08/16 15:08:42 citizen428 Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="Facets is an extension library adding extra functionality to Ruby"
HOMEPAGE="http://calibre.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/4518/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=dev-lang/ruby-1.8"

pkg_postinst() {
	einfo "This package was installed using a 'gem'."
	einfo "If you are intending to write code which"
	einfo "requires ${PN}, you will need to"
	einfo
	einfo "require 'rubygems'"
	einfo
	einfo "before requiring '${PN}'."
}
