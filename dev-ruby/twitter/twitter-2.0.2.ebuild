# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/twitter/twitter-2.0.2.ebuild,v 1.3 2012/02/11 16:10:39 tomka Exp $

EAPI="2"
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC="yard"
RUBY_FAKEGEM_EXTRADOC="HISTORY.md README.md"

inherit ruby-fakegem

DESCRIPTION="Ruby wrapper around the Twitter API"
HOMEPAGE="http://twitter.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend "
	=dev-ruby/activesupport-3*
	=dev-ruby/faraday-0*
	>=dev-ruby/faraday-0.7
	=dev-ruby/multi_json-1*
	=dev-ruby/simple_oauth-0*"

ruby_add_bdepend "test? (
	dev-ruby/rspec:2
	dev-ruby/webmock
	)
	doc? ( dev-ruby/yard )"

all_ruby_prepare() {
	rm Gemfile || die
	sed -i -e '/[Bb]undler/d' Rakefile || die "Unable to remove bundler code."

	sed -i -e '/[sS]imple[cC]ov/ s:^:#:' spec/helper.rb || die
}

each_ruby_test() {
	${RUBY} -S rspec spec || die
}
