# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/json/json-1.4.6-r1.ebuild,v 1.2 2010/11/03 18:37:47 graaff Exp $

EAPI=2
USE_RUBY="ruby18 ree18 ruby19 jruby"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES TODO README"
RUBY_FAKEGEM_DOCDIR="doc"

inherit multilib ruby-fakegem

DESCRIPTION="A JSON implementation as a Ruby extension."
HOMEPAGE="http://json.rubyforge.org/"
LICENSE="|| ( Ruby GPL-2 )"
SRC_URI="mirror://rubygems/${P}.gem"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x64-macos ~x86-solaris"
SLOT="0"
IUSE=""

RDEPEND="${RDEPEND}"
DEPEND="${DEPEND}
	dev-util/ragel"

ruby_add_bdepend "dev-ruby/rake
	test? ( virtual/ruby-test-unit )"

all_ruby_prepare() {
	# Avoid building the extension twice!
	# And use rdoc instead of sdoc which we don't have packaged
	sed -i \
		-e 's| => :compile_ext||' \
		-e 's| => :clean||' \
		-e 's|sdoc|rdoc|' \
		Rakefile || die "rakefile fix failed"
}

each_ruby_compile() {
	if [[ $(basename ${RUBY}) != "jruby" ]]; then
		${RUBY} -S rake compile_ext || die "extension compile failed"
	fi
}

each_ruby_test() {
	JSON=pure \
	${RUBY} -Iext:lib -S testrb tests/*.rb || die "pure ruby tests failed"

	if [[ $(basename ${RUBY}) != "jruby" ]]; then
		JSON=ext \
		${RUBY} -Iext:lib -S testrb tests/*.rb || die "ext ruby tests failed"
	fi
}

each_ruby_install() {
	each_fakegem_install
	if [[ $(basename ${RUBY}) != "jruby" ]]; then
		ruby_fakegem_newins ext/json/ext/generator$(get_modname) lib/json/ext/generator$(get_modname)
		ruby_fakegem_newins ext/json/ext/parser$(get_modname) lib/json/ext/parser$(get_modname)
	fi
}
