# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/activemodel/activemodel-3.0.3-r1.ebuild,v 1.2 2011/02/13 21:21:27 tomka Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

RUBY_FAKEGEM_GEMSPEC="activemodel.gemspec"

inherit ruby-fakegem

DESCRIPTION="A toolkit for building modeling frameworks like Active Record and Active Resource."
HOMEPAGE="http://github.com/rails/rails"
SRC_URI="http://github.com/rails/rails/tarball/v${PV} -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="3.0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

S="${WORKDIR}/rails-rails-*/activemodel"

ruby_add_rdepend "
	~dev-ruby/activesupport-${PV}
	>=dev-ruby/builder-2.1.2
	>=dev-ruby/i18n-0.4.1:0.4"

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

	# Relax builder requirement to also support 3.0.0
	sed -i -e 's/~> 2.1.2/>= 2.1.2/' activemodel.gemspec || die
}
