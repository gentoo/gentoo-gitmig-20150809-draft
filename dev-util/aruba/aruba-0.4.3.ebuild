# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/aruba/aruba-0.4.3.ebuild,v 1.1 2011/06/30 17:26:53 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="cucumber"
RUBY_FAKEGEM_EXTRADOC="History.md README.md"

RUBY_FAKEGEM_GEMSPEC="aruba.gemspec"

inherit ruby-fakegem

DESCRIPTION="Cucumber steps for driving out command line applications."
HOMEPAGE="https://github.com/aslakhellesoy/aruba"
LICENSE="MIT"

KEYWORDS="~amd64"
SLOT="0"
IUSE=""

ruby_add_bdepend "test? (
		>=dev-util/cucumber-0.10.3
		>=dev-ruby/rspec-2.6.0
	)"

ruby_add_rdepend "
	>=dev-ruby/bcat-0.6.1
	>=dev-ruby/childprocess-0.1.9
	>=dev-util/cucumber-0.10.3
	>=dev-ruby/rdiscount-1.6.8"

all_ruby_prepare() {
	# Remove bundler-related code.
	sed -i -e '/[Bb]undler/d' Rakefile || die
	rm Gemfile || die

	# Lower cucumber requirement to avoid bootstrap issues and make the
	# upgrade path harder. All features pass with 0.10.3 as well.
	sed -i -e 's/0.10.7/0.10.3/' aruba.gemspec || die
}
