# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rspec/rspec-1.3.0.ebuild,v 1.3 2010/01/14 16:22:24 ranger Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.rdoc README.rdoc TODO.txt Ruby1.9.rdoc Upgrade.rdoc"

inherit ruby-fakegem

DESCRIPTION="A Behaviour Driven Development (BDD) framework for Ruby"
HOMEPAGE="http://rspec.rubyforge.org/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

ruby_add_bdepend doc dev-ruby/hoe

# Only require the test packages for ruby18 as we _really_ won't be
# running tests for Ruby 1.9 and JRuby just yet :(
USE_RUBY=ruby18 \
	ruby_add_bdepend test "dev-ruby/hoe dev-ruby/zentest dev-ruby/heckle dev-ruby/fakefs"

each_ruby_test() {
	if [[ $(basename ${RUBY}) == "ruby19" ]]; then
		ewarn "Tests for Ruby 1.9 fail, among the other reasons because interop only works"
		ewarn "for test-unit-1.2.3 (and not test-unit-2.x). Since we know about those failures"
		ewarn "as well as upstream, we won't be proceeding with this for now."
		return 0
	fi

	if [[ $(basename ${RUBY}) == "jruby" ]]; then
		ewarn "Tests for JRuby are disabled because dev-ruby/fakefs does not currently support"
		ewarn "JRuby properly and it's needed to run the tests."
		return 0
	fi
}
