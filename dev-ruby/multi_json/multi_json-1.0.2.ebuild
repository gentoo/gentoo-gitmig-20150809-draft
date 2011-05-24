# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/multi_json/multi_json-1.0.2.ebuild,v 1.1 2011/05/24 09:09:20 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"
RUBY_FAKEGEM_TASK_DOC="rdoc"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc"

RUBY_FAKEGEM_GEMSPEC="multi_json.gemspec"

inherit ruby-fakegem

DESCRIPTION="A gem to provide swappable JSON backends"
HOMEPAGE="http://github.com/intridea/multi_json"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

ruby_add_rdepend "|| ( >=dev-ruby/json-1.4 >=dev-ruby/yajl-ruby-0.7 =dev-ruby/activesupport-3* )"

# I've switched one of the tests from requiring yajl to requiring
# json-pure since it's the only implementation that is available for
# all the Ruby interpreters we support.
ruby_add_bdepend "test? ( dev-ruby/rspec:2 dev-ruby/json )"

all_ruby_prepare() {
	sed -i -e '/[Bb]undler/d' Rakefile spec/spec_helper.rb || die "Unable to remove bundler."
	rm Gemfile || die "Unable to remove bundler Gemfile."

	# Provide version otherwise provided by bundler.
	sed -i -e "s/#{MultiJson::VERSION}/${PV}/" Rakefile || die
}
