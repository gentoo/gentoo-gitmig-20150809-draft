# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activesupport/activesupport-3.0.9.ebuild,v 1.3 2011/08/07 18:04:06 armin76 Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

RUBY_FAKEGEM_GEMSPEC="activesupport.gemspec"

inherit ruby-fakegem

DESCRIPTION="Utility Classes and Extension to the Standard Library"
HOMEPAGE="http://rubyforge.org/projects/activesupport/"
SRC_URI="https://github.com/rails/rails/tarball/v${PV} -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="3.0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

S="${WORKDIR}/rails-rails-*/${PN}"

ruby_add_rdepend ">=dev-ruby/memcache-client-1.5.8"

# libxml-ruby and nokogiri are not strictly needed, but there are tests
# using this code.
ruby_add_bdepend "test? ( virtual/ruby-test-unit >=dev-ruby/libxml-2.0.0 dev-ruby/nokogiri )"

all_ruby_prepare() {
	# don't support older mocha versions as the optional codepath
	# breaks JRuby
	epatch "${FILESDIR}"/${PN}-3.0.3-mocha-0.9.5.patch

	# Set test environment to our hand.
	rm "${S}/../Gemfile" || die "Unable to remove Gemfile"
	sed -i -e '/load_paths/d' test/abstract_unit.rb || die "Unable to remove load paths"
}
