# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activesupport/activesupport-3.0.3.ebuild,v 1.3 2010/12/28 13:51:34 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

RUBY_FAKEGEM_GEMSPEC="activesupport.gemspec"

inherit ruby-fakegem

DESCRIPTION="Utility Classes and Extension to the Standard Library"
HOMEPAGE="http://rubyforge.org/projects/activesupport/"
SRC_URI="http://github.com/rails/rails/tarball/v${PV} -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="3.0"
KEYWORDS="~amd64 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

S="${WORKDIR}/rails-rails-*/${PN}"

ruby_add_rdepend ">=dev-ruby/builder-2.1.2
	>=dev-ruby/tzinfo-0.3.16
	>=dev-ruby/i18n-0.4.1:0.4
	>=dev-ruby/memcache-client-1.5.8"

ruby_add_bdepend "test? (
		!dev-ruby/test-unit:2
		virtual/ruby-test-unit
	)"

all_ruby_prepare() {
	# don't support older mocha versions as the optional codepath
	# breaks JRuby
	epatch "${FILESDIR}"/${P}-mocha-0.9.5.patch

	# Set test environment to our hand.
	rm "${S}/../Gemfile" || die "Unable to remove Gemfile"
	sed -i -e '/load_paths/d' test/abstract_unit.rb || die "Unable to remove load paths"

	# Remove tests that have issues and need further investigation. It
	# looks like SAX behaviour changed at some point in libxml2.
	rm test/xml_mini/libxmlsax_engine_test.rb test/xml_mini/nokogirisax_engine_test.rb || die "Unable to remove failing test."
}
