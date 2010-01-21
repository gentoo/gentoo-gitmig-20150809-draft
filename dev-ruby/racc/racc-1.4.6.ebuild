# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/racc/racc-1.4.6.ebuild,v 1.3 2010/01/21 11:23:46 flameeyes Exp $

EAPI=2

# jruby → testsuite uses fork (incompatible with JRuby), and patched
# one crashes JRuby 1.4.0.
USE_RUBY="ruby18 ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.en.rdoc README.ja.rdoc TODO ChangeLog"

inherit ruby-fakegem

DESCRIPTION="A LALR(1) parser generator for Ruby"
HOMEPAGE="http://www.loveruby.net/en/racc.html"

LICENSE="LGPL-2.1"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

ruby_add_bdepend test virtual/ruby-test-unit

all_ruby_prepare() {
	sed -i -e '/tasks\/email/s:^:#:' Rakefile || die "rakefile fix failed"
	sed -i -e '/prerequisites/s:^:#:' tasks/test.rb || die "test task fix failed"
	sed -i -e 's|/tmp/out|${TMPDIR:-/tmp}/out|' test/helper.rb || die "tests fix failed"

	epatch "${FILESDIR}"/${P}-test-unit.patch
}

each_ruby_prepare() {
	if [[ $(basename ${RUBY}) == "ruby18" ]]; then
		sed -i -e 's:ruby/ruby.h:ruby.h:' \
			ext/racc/cparse/cparse.c || die
	fi
}

each_ruby_compile() {
	case ${RUBY} in
		*jruby)
			einfo "Under JRuby, racc cannot use the shared object parser, so instead"
			einfo "you have to rely on the pure Ruby implementation."
			;;
		*)
			${RUBY} -S rake build || die "build failed"
			# Copy over the file here so that we don't have to do
			# special ruby install for JRuby and the other
			# implementations.
			cp -l ext/racc/cparse/cparse.so lib/racc/cparse.so || die
			;;
	esac
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc sample/* || die
}
