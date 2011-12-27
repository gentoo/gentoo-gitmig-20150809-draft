# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activemodel/activemodel-3.1.3.ebuild,v 1.2 2011/12/27 09:10:46 graaff Exp $

EAPI=4

USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG.md README.rdoc"

RUBY_FAKEGEM_GEMSPEC="activemodel.gemspec"

inherit ruby-fakegem

DESCRIPTION="A toolkit for building modeling frameworks like Active Record and Active Resource."
HOMEPAGE="http://github.com/rails/rails"
SRC_URI="http://github.com/rails/rails/tarball/v${PV} -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="3.1"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RUBY_S="rails-rails-*/activemodel"

ruby_add_rdepend "
	~dev-ruby/activesupport-${PV}
	>=dev-ruby/builder-3.0.0
	>=dev-ruby/i18n-0.6.0:0.6
	>=dev-ruby/bcrypt-ruby-3.0.0"

ruby_add_bdepend "
	test? (
		dev-ruby/ruby-debug
		>=dev-ruby/mocha-0.9.5
		virtual/ruby-test-unit
	)"

all_ruby_prepare() {
	# Set test environment to our hand.
	rm "${S}/../Gemfile" || die "Unable to remove Gemfile"
	sed -i -e '/load_paths/d' test/cases/helper.rb || die "Unable to remove load paths"
}
