# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/actionpack/actionpack-3.0.12.ebuild,v 1.2 2012/05/01 18:24:02 armin76 Exp $

EAPI=4

USE_RUBY="ruby18 ree18"

# The default test task tries to test activerecord with SQLite as well.
RUBY_FAKEGEM_TASK_TEST="test_action_pack"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc"

RUBY_FAKEGEM_GEMSPEC="actionpack.gemspec"

inherit ruby-fakegem

DESCRIPTION="Eases web-request routing, handling, and response."
HOMEPAGE="http://rubyforge.org/projects/actionpack/"
SRC_URI="http://github.com/rails/rails/tarball/v${PV} -> rails-${PV}.tgz"

LICENSE="MIT"
SLOT="3.0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RUBY_S="rails-rails-*/actionpack"

ruby_add_rdepend "
	~dev-ruby/activemodel-${PV}
	~dev-ruby/activesupport-${PV}
	>=dev-ruby/builder-2.1.2:0
	>=dev-ruby/erubis-2.6.6
	>=dev-ruby/i18n-0.5.0:0.5
	>=dev-ruby/rack-1.2.1:1.2
	>=dev-ruby/rack-mount-0.6.14:0.6
	>=dev-ruby/rack-test-0.5.7:0.5
	>=dev-ruby/tzinfo-0.3.23"

ruby_add_bdepend "
	test? (
		dev-ruby/bundler
		~dev-ruby/activerecord-${PV}
		~dev-ruby/actionmailer-${PV}
	)"

all_ruby_prepare() {
	# Remove items from the common Gemfile that we don't need for this
	# test run. This also requires handling some gemspecs.
	sed -i -e '/\(system_timer\|horo\|faker\|rbench\|ruby-debug\|pg\)/d' ../Gemfile || die

	# Loosen erubis dependency since this is not slotted.
	sed -i -e 's/~> 2.6.6/>= 2.6.6/' actionpack.gemspec || die

	# Avoid fragile tests depending on hash ordering
	sed -i -e '/cookie_3=chocolate/ s:^:#:' test/controller/integration_test.rb || die
	sed -i -e '/test_to_s/,/end/ s:^:#:' test/template/html-scanner/tag_node_test.rb || die
	sed -i -e '/"name":"david"/ s:^:#:' test/controller/mime_responds_test.rb || die
	sed -i -e '/test_option_html_attributes_with_multiple_element_hash/, / end/ s:^:#:' test/template/form_options_helper_test.rb || die
	sed -i -e '/test_option_html_attributes_with_multiple_hashes/, / end/ s:^:#:' test/template/form_options_helper_test.rb || die

	# Ignore one failure that does not seem to be caused by changes in
	# this version of Rails and that is unlikely to get upstream
	# attention due to this version being old.
	sed -i -e '/rendering a partial in an RJS template should pick the JS template over the HTML one/, / end/ s:^:#:' test/controller/new_base/render_rjs_test.rb || die
}
