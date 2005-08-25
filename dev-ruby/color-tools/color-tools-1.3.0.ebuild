# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/color-tools/color-tools-1.3.0.ebuild,v 1.1 2005/08/25 12:49:41 citizen428 Exp $

inherit ruby gems

DESCRIPTION="Ruby library to provide RGB and CMYK colour support."
HOMEPAGE="http://ruby-pdf.rubyforge.org/color-tools/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

USE_RUBY="ruby18"
DEPEND="virtual/ruby"

pkg_postinst() {
	einfo "This package was installed using a 'gem'."
	einfo "If you are intending to write code which"
	einfo "requires ${PN}, you will need to"
	einfo
	einfo "require 'rubygems'"
	einfo
	einfo "before requiring '${PN}'."
}

