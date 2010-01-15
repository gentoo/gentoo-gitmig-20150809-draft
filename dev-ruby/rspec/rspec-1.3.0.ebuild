# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rspec/rspec-1.3.0.ebuild,v 1.4 2010/01/15 00:39:55 flameeyes Exp $

EAPI=2
USE_RUBY="ruby18 ruby19 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

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

# don't require test dependencies for jruby since we cannot run them
# for now (fakefs doesn't work).
#
# We should add nokogiri here to make sure that we test as much as
# possible, but since it's yet unported to 1.9 and the nokogiri-due
# tests fail for sure, we'll be waiting on it.
USE_RUBY="ruby18 ruby19" \
	ruby_add_bdepend test "dev-ruby/hoe dev-ruby/zentest dev-ruby/fakefs"

# the testsuite skips over heckle for Ruby 1.9 so we only request it for 1.8
USE_RUBY="ruby18" \
	ruby_add_bdepend test "dev-ruby/heckle"

all_ruby_prepare() {
	# Replace reference to /tmp to our temporary directory to avoid
	# sandbox-related failure.
	sed -i \
		-e "s:/tmp:${T}:" \
		spec/spec/runner/command_line_spec.rb || die
}

src_test() {
	chmod 0755 ${WORKDIR/work/homedir} || die "Failed to fix permissions on home"
	ruby-ng_src_test
}

each_ruby_test() {
	case ${RUBY} in
		*jruby)
			ewarn "Tests for JRuby are disabled because dev-ruby/fakefs does not currently support"
			ewarn "JRuby properly and it's needed to run the tests."
			;;
		*)
			each_fakegem_test
			;;
	esac
}
