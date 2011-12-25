# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/aruba/aruba-0.4.10.ebuild,v 1.1 2011/12/25 11:00:43 graaff Exp $

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

DEPEND="${DEPEND} test? ( sys-devel/bc )"
RDEPEND="${RDEPEND}"

ruby_add_bdepend "test? (
		>=dev-util/cucumber-1.0.2
		>=dev-ruby/rspec-2.6.0
	)"

ruby_add_rdepend "
	>=dev-ruby/bcat-0.6.1
	>=dev-ruby/childprocess-0.2.3
	>=dev-util/cucumber-1.1.1"

all_ruby_prepare() {
	# Remove bundler-related code.
	sed -i -e '/[Bb]undler/d' Rakefile || die
	rm Gemfile || die
}
