# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/webmock/webmock-0.8.0.ebuild,v 1.1 2010/01/04 04:13:38 flameeyes Exp $

EAPI=2

# ruby19 → tests fail with a trivial difference, reported upstream
# http://github.com/bblimke/webmock/issues/#issue/7
# jruby → tests fail badly, reported upstream
# http://github.com/bblimke/webmock/issues/#issue/8
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_TEST="test spec"

RUBY_FAKEGEM_DOCDIR="rdoc"
RAKE_FAKEGEM_EXTRADOC="CHANGELOG README.md"

inherit ruby-fakegem

DESCRIPTION="Allows stubbing HTTP requests and setting expectations on HTTP requests"
HOMEPAGE="http://github.com/bblimke/webmock"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend dev-ruby/addressable

ruby_add_bdepend test 'virtual/ruby-test-unit >=dev-ruby/rspec-1.2.9 >=dev-ruby/httpclient-2.1.5.2'

all_ruby_prepare() {
	# Don't require check_dependencies (using Jeweler)
	sed -i \
		-e '/=> :check_dependencies/s:^:#:' \
		Rakefile || die "Rakefile fix failed"
}
