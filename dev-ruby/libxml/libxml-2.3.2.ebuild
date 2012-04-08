# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/libxml/libxml-2.3.2.ebuild,v 1.1 2012/04/08 09:29:08 graaff Exp $

EAPI=2

USE_RUBY="ruby18 ree18 ruby19"

RUBY_FAKEGEM_NAME="libxml-ruby"

RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="README.rdoc HISTORY"

RUBY_FAKEGEM_TASK_TEST="none"

inherit ruby-fakegem

DESCRIPTION="Ruby libxml with a user friendly API, akin to REXML, but feature complete and significantly faster."
HOMEPAGE="http://libxml.rubyforge.org"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="${RDEPEND} dev-libs/libxml2"
DEPEND="${DEPEND} dev-libs/libxml2"

ruby_add_bdepend "doc? ( dev-ruby/rdoc )
	test? ( virtual/ruby-test-unit )"

all_ruby_prepare() {
	# Remove grancher tasks only needed for publishing the website
	sed -i -e '/grancher/d' -e '/Grancher/,$d' Rakefile || die

	# We don't have the hanna template available.
	sed -i -e 's/hanna/rake/' Rakefile || die

	# Remove rake-compiler bits since we don't use it
	sed -i -e '/extensiontask/d' -e '/ExtensionTask/,/end/d' -e '/GemPackageTask/,/end/d' Rakefile || die

	# replace ulimit -n output as it does not work with Ruby 1.9
	sed -i -e 's:`ulimit -n`:"'`ulimit -n`'":' test/tc_parser.rb || die
}

each_ruby_configure() {
	${RUBY} -C ext/libxml extconf.rb || die
}

each_ruby_compile() {
	emake -C ext/libxml
	cp ext/libxml/libxml_ruby.so lib/ || die
}

each_ruby_test() {
	# The test suite needs to load its files in alphabetical order but
	# this is not guaranteed. See bug 370501.
	${RUBY} -Ilib -r ./test/test_helper.rb test/test_suite.rb || die
}
