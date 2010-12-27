# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/webmock/webmock-1.6.1.ebuild,v 1.2 2010/12/27 20:31:20 grobian Exp $

EAPI=2

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_TEST="test spec NO_CONNECTION=true"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="Allows stubbing HTTP requests and setting expectations on HTTP requests"
HOMEPAGE="http://github.com/bblimke/webmock"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

ruby_add_rdepend ">=dev-ruby/addressable-2.2.2 >=dev-ruby/crack-0.1.7"

ruby_add_bdepend "test? (
	virtual/ruby-test-unit
	dev-ruby/rspec:2
	>=dev-ruby/httpclient-2.1.5.2
	>=dev-ruby/patron-0.4.9-r1
	>=dev-ruby/em-http-request-0.2.14
	)"

all_ruby_prepare() {
	# Don't require check_dependencies (using Jeweler)
	sed -i \
		-e '/=> :check_dependencies/s:^:#:' \
		Rakefile || die "Rakefile fix failed"

	# There is now optional support for curb which we don't have in
	# Gentoo yet.
	sed -i -e '/curb/d' spec/spec_helper.rb || die
	rm spec/curb_spec.rb || die
}
