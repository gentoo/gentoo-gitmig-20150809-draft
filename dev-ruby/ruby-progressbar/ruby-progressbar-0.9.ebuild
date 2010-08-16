# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-progressbar/ruby-progressbar-0.9.ebuild,v 1.10 2010/08/16 23:20:15 jer Exp $

inherit ruby

DESCRIPTION="A Text Progress Bar Library for Ruby"
HOMEPAGE="http://0xcc.net/ruby-progressbar/"
SRC_URI="http://0xcc.net/ruby-progressbar/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
USE_RUBY="ruby18"
KEYWORDS="alpha ia64 ppc64 sparc"

IUSE=""

src_test() {
	${RUBY} -I. test.rb || die "test failed"
}

src_install() {
	rm test.rb
	ruby_src_install
}
