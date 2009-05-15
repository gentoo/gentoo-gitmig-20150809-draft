# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-progressbar/ruby-progressbar-0.8.ebuild,v 1.16 2009/05/15 14:49:46 flameeyes Exp $

inherit ruby

DESCRIPTION="A Text Progress Bar Library for Ruby"
HOMEPAGE="http://www.namazu.org/~satoru/ruby-progressbar/"
SRC_URI="http://namazu.org/~satoru/ruby-progressbar/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
USE_RUBY="ruby18"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"

IUSE=""

DEPEND="virtual/ruby"

src_test() {
	${RUBY} -I. test.rb || die "test failed"
}

src_install() {
	rm test.rb
	ruby_src_install
}
