# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/webmock/webmock-1.4.0.ebuild,v 1.2 2010/10/22 14:58:56 fauli Exp $

EAPI=2

USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_TEST="test spec"

RUBY_FAKEGEM_DOCDIR="rdoc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.md"

inherit ruby-fakegem

DESCRIPTION="Allows stubbing HTTP requests and setting expectations on HTTP requests"
HOMEPAGE="http://github.com/bblimke/webmock"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_rdepend ">=dev-ruby/addressable-2.2.2 >=dev-ruby/crack-0.1.7"

ruby_add_bdepend "test? (
	virtual/ruby-test-unit
	>=dev-ruby/rspec-1.2.9:0
	>=dev-ruby/httpclient-2.1.5.2
	>=dev-ruby/patron-0.4.9-r1
	>=dev-ruby/em-http-request-0.2.14
	dev-ruby/json
	)"

# Remove specs that require a network connection. Note that one of
# them fails even with network connection:
# http://github.com/bblimke/webmock/issues/issue/53
RUBY_PATCHES=(
	"${FILESDIR}/${P}-network-specs.patch"
	"${FILESDIR}/${P}-tmpdir.patch"
)

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
