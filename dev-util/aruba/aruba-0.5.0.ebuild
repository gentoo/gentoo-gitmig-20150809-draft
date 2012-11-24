# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/aruba/aruba-0.5.0.ebuild,v 1.1 2012/11/24 08:21:37 graaff Exp $

EAPI=4
USE_RUBY="ruby18 ruby19 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="cucumber"
RUBY_FAKEGEM_EXTRADOC="History.md README.md"

RUBY_FAKEGEM_GEMSPEC="aruba.gemspec"

inherit ruby-fakegem

DESCRIPTION="Cucumber steps for driving out command line applications."
HOMEPAGE="https://github.com/cucumber/aruba"
LICENSE="MIT"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
IUSE=""

DEPEND="${DEPEND} test? ( sys-devel/bc )"
RDEPEND="${RDEPEND}"

ruby_add_rdepend "
	>=dev-ruby/bcat-0.6.1
	>=dev-ruby/childprocess-0.2.3
	>=dev-ruby/rspec-2.6
	>=dev-util/cucumber-1.1.1"

all_ruby_prepare() {
	# Remove bundler-related code.
	sed -i -e '/[Bb]undler/d' Rakefile || die
	rm Gemfile || die

	# Relax childprocess dependency. We don't have this old version
	# anymore and this is only done to handle changed semantics for
	# non-existing files.  Also remove references to git ls-files.
	sed -i -e 's/= 0.2.3/>= 0.2.3/' \
		-e '/git ls-files/d' \
		aruba.gemspec || die

	# see https://github.com/cucumber/aruba/issues/106
	# Avoid features depending on deprecated childprocess behavior.
	sed -i -e '34,39 s/@posix/@posix @wip/' features/exit_statuses.feature || die
	sed -i -e '7 s/@posix/@posix @wip/' features/output.feature || die
}
