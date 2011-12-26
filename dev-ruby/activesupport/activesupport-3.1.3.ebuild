# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activesupport/activesupport-3.1.3.ebuild,v 1.1 2011/12/26 08:25:55 graaff Exp $

EAPI=4

# jruby fails tests.
USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_GEMSPEC="activesupport.gemspec"

inherit ruby-fakegem

DESCRIPTION="Utility Classes and Extension to the Standard Library"
HOMEPAGE="http://rubyforge.org/projects/activesupport/"
SRC_URI="https://github.com/rails/rails/tarball/v${PV} -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="3.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RUBY_S="rails-rails-*/${PN}"

ruby_add_rdepend ">=dev-ruby/memcache-client-1.5.8
	>=dev-ruby/multi_json-1.0
	dev-ruby/i18n:0.6"

# libxml-ruby, nokogiri, and builder are not strictly needed, but there
# are tests using this code.
ruby_add_bdepend "test? (
	virtual/ruby-test-unit
	>=dev-ruby/libxml-2.0.0
	dev-ruby/nokogiri
	dev-ruby/builder:0
	)"

all_ruby_prepare() {
	# don't support older mocha versions as the optional codepath
	# breaks JRuby
	epatch "${FILESDIR}"/${PN}-3.0.3-mocha-0.9.5.patch

	# Set test environment to our hand.
#	rm "${S}/../Gemfile" || die "Unable to remove Gemfile"
	sed -i -e '/load_paths/d' test/abstract_unit.rb || die "Unable to remove load paths"
}
