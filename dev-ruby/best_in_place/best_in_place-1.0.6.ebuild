# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/best_in_place/best_in_place-1.0.6.ebuild,v 1.1 2012/01/24 10:38:54 flameeyes Exp $

EAPI=4
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.md"

RUBY_FAKEGEM_GEMSPEC="${PN}.gemspec"

# if ever needed
#GITHUB_USER="bernat"
#GITHUB_PROJECT="${PN}"
#RUBY_S="${GITHUB_USER}-${GITHUB_PROJECT}-*"

inherit virtualx ruby-fakegem

DESCRIPTION="In-place editor helper for Rails 3o"
HOMEPAGE="http://github.com/bernat/best_in_place"

LICENSE="MIT"
SLOT="3"
KEYWORDS="~amd64"
IUSE=""

ruby_add_rdepend "
	dev-ruby/rails:3.1
	dev-ruby/jquery-rails
"

ruby_add_bdepend "
	test? (
		dev-ruby/rspec-rails
		>=dev-ruby/nokogiri-1.5.0
		>=dev-ruby/capybara-1.0.1
		>=dev-ruby/sqlite3-ruby-1.3.4-r1
		dev-ruby/rdiscount
	)"

DEPEND+=" test? ( www-client/firefox )"

all_ruby_prepare() {
	sed -i \
		-e '/git ls-files/d' \
		-e '/rspec-rails/s:,.*::' \
		${RUBY_FAKEGEM_GEMSPEC} || die

	# let test_app work with Rails 3.1 (since we lack 3.2 for now).
	sed -i \
		-e '/gem .rails/s:3.2:~> 3.1:' \
		-e '/gem .\(coffee\|sass\)/s:3\.2\..:3.1.0:' \
		test_app/Gemfile || die
}

each_ruby_test() {
	RAILS_ENV=test ${RUBY} -C test_app -S rake db:migrate || die "test_app migration failed"
	VIRTUALX_COMMAND="${RUBY}" virtualmake -S rake spec || die "Specs failed"
}
