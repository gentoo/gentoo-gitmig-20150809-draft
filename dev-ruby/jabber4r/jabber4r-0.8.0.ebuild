# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/jabber4r/jabber4r-0.8.0.ebuild,v 1.5 2007/01/05 16:46:26 flameeyes Exp $

inherit ruby gems

DESCRIPTION="A Jabber library in pure Ruby"
HOMEPAGE="http://jabber4r.rubyforge.org/"
SRC_URI="http://rubyforge.org/frs/download.php/5572/${P}.gem"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ia64 x86"
IUSE=""

USE_RUBY="ruby18 ruby19"
DEPEND="virtual/ruby"

pkg_postinst() {
	elog "This package was installed using a 'gem'."
	elog "If you are intending to write code which"
	elog "requires ${PN}, you will need to"
	elog
	elog "require 'rubygems'"
	elog
	elog "before requiring '${PN}'."
}
