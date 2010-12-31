# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/msgpack/msgpack-0.4.4.ebuild,v 1.1 2010/12/31 22:41:00 graaff Exp $

EAPI="2"

# ruby19 → tests fail
# jruby → uses a binary extension
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Binary-based efficient data interchange format for ruby binding"
HOMEPAGE="http://msgpack.sourceforge.jp/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

each_ruby_configure() {
	${RUBY} -Cext extconf.rb || die "Configuration of extension failed."
}

each_ruby_compile() {
	emake -Cext || die

	mkdir lib || die "Unable to make lib directory."
	cp ext/msgpack.so lib/ || die "Unable to install msgpack library."
}

each_ruby_test() {
	${RUBY} test/test_cases.rb || die "tests failed"
	${RUBY} test/test_pack_unpack.rb || die "tests failed"
}
