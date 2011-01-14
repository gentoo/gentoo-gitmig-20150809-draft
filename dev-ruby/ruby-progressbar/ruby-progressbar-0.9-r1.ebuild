# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-progressbar/ruby-progressbar-0.9-r1.ebuild,v 1.1 2011/01/14 16:38:38 matsuu Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19 ree18 jruby"

inherit ruby-ng

DESCRIPTION="A Text Progress Bar Library for Ruby"
HOMEPAGE="http://0xcc.net/ruby-progressbar/"
SRC_URI="http://0xcc.net/ruby-progressbar/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"

IUSE=""

each_ruby_test() {
	${RUBY} -I. test.rb || die "test failed"
}

each_ruby_install() {
	doruby progressbar.rb
}

all_ruby_install() {
	dodoc ChangeLog  progressbar.*.rd || die
}
