# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/webmock/webmock-1.3.5.ebuild,v 1.1 2010/10/03 08:38:07 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19"

# We should also be running the specs using 'spec', but they are
# broken when both rspec 1.x and rspec 2.x are installed:
# http://github.com/bblimke/webmock/issues/issue/44
RUBY_FAKEGEM_TASK_TEST="test"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="Allows stubbing HTTP requests and setting expectations on HTTP requests"
HOMEPAGE="http://github.com/bblimke/webmock"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend ">=dev-ruby/addressable-2.1.1 >=dev-ruby/crack-0.1.7"

ruby_add_bdepend "test? (
	virtual/ruby-test-unit
	>=dev-ruby/rspec-1.2.9:0
	>=dev-ruby/httpclient-2.1.5.2
	>=dev-ruby/patron-0.4.9-r1
	>=dev-ruby/em-http-request-0.2.7
	)"

all_ruby_prepare() {
	# Don't require check_dependencies (using Jeweler)
	sed -i \
		-e '/=> :check_dependencies/s:^:#:' \
		Rakefile || die "Rakefile fix failed"
}
