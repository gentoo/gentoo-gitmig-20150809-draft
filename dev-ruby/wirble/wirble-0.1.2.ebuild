# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/wirble/wirble-0.1.2.ebuild,v 1.1 2007/02/04 03:37:29 pclouds Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Wirble is a set of enhancements for Irb."
HOMEPAGE="http://pablotron.org/software/wirble/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86"
DEPEND=""
IUSE=""

pkg_postinst() {
	einfo "The quick way to use wirble is to make your ~/.irbrc look like this:"
	einfo "  # load libraries"
	einfo "  require 'rubygems'"
	einfo "  require 'wirble'"
	einfo "  "
	einfo "  # start wirble (with color)"
	einfo "  Wirble.init"
	einfo "  Wirble.colorize"
}
