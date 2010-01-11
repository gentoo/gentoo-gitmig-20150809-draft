# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-progressbar/ruby-progressbar-0.9.ebuild,v 1.5 2010/01/11 18:11:42 armin76 Exp $

inherit ruby

DESCRIPTION="A Text Progress Bar Library for Ruby"
HOMEPAGE="http://0xcc.net/ruby-progressbar/"
SRC_URI="http://0xcc.net/ruby-progressbar/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
USE_RUBY="ruby18"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"

IUSE=""

src_test() {
	${RUBY} -I. test.rb || die "test failed"
}

src_install() {
	rm test.rb
	ruby_src_install
}
