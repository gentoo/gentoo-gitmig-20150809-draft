# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rubypants/rubypants-0.2.0-r2.ebuild,v 1.3 2011/06/13 10:19:15 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ruby19 jruby ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="A Ruby port of the SmartyPants PHP library."
HOMEPAGE="http://chneukirchen.org/repos/rubypants/README"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

each_ruby_install() {
	ruby_fakegem_install_gemspec

	ruby_fakegem_newins rubypants.rb lib/rubypants.rb
}

each_ruby_test() {
	# The rakefile doesn't really implement it properly, so simply
	# replace it here.
	${RUBY} -I. test_rubypants.rb || die "tests failed"
}
