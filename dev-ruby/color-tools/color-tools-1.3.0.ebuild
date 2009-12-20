# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/color-tools/color-tools-1.3.0.ebuild,v 1.10 2009/12/20 12:03:35 graaff Exp $

inherit ruby gems

DESCRIPTION="Ruby library to provide RGB and CMYK colour support."
HOMEPAGE="http://ruby-pdf.rubyforge.org/color-tools/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ia64 ppc64 x86"
IUSE=""

USE_RUBY="ruby18"

pkg_postinst() {
	elog "This package was installed using a 'gem'."
	elog "If you are intending to write code which"
	elog "requires ${PN}, you will need to"
	elog
	elog "require 'rubygems'"
	elog
	elog "before requiring '${PN}'."
}
