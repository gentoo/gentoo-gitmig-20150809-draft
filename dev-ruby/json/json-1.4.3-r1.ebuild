# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/json/json-1.4.3-r1.ebuild,v 1.4 2010/06/29 10:31:57 angelos Exp $

EAPI=2
USE_RUBY="ruby18 jruby"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES TODO README"
RUBY_FAKEGEM_DOCDIR="doc"

inherit multilib ruby-fakegem

DESCRIPTION="A JSON implementation as a Ruby extension."
HOMEPAGE="http://json.rubyforge.org/"
LICENSE="|| ( Ruby GPL-2 )"
SRC_URI="mirror://rubygems/${P}.gem"

KEYWORDS="amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-solaris"
SLOT="0"
IUSE=""

RDEPEND="${RDEPEND}"
DEPEND="${DEPEND}
	dev-util/ragel"

ruby_add_bdepend "dev-ruby/rake
	test? ( virtual/ruby-test-unit )"

all_ruby_prepare() {
	# Avoid building the extension twice!
	sed -i \
		-e 's| => :compile_ext||' \
		-e 's| => :clean||' \
		Rakefile || die "rakefile fix failed"
}

each_ruby_compile() {
	if [[ $(basename ${RUBY}) != "jruby" ]]; then
		${RUBY} -S rake compile_ext || die "extension compile failed"
	fi
}

each_ruby_test() {
	# We have to set RUBYLIB because otherwise the tests will run
	# against the sytem-installed json; at the same time, we cannot
	# use the -I parameter because rake won't let it pass to the
	# testrb call that is executed down the road.

	RUBYLIB="${RUBYLIB}${RUBYLIB+:}lib:ext/json/ext" \
		${RUBY} -S rake test_pure || die "pure ruby tests failed"

	if [[ $(basename ${RUBY}) != "jruby" ]]; then
		RUBYLIB="${RUBYLIB}${RUBYLIB+:}lib:ext" \
			${RUBY} -Ilib:ext -S rake test_ext || die " ruby extension tests failed"
	fi
}

each_ruby_install() {
	each_fakegem_install
	if [[ $(basename ${RUBY}) != "jruby" ]]; then
		ruby_fakegem_newins ext/json/ext/generator$(get_modname) lib/json/ext/generator$(get_modname)
		ruby_fakegem_newins ext/json/ext/parser$(get_modname) lib/json/ext/parser$(get_modname)
	fi
}
