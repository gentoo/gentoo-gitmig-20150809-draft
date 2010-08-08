# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-filemagic/ruby-filemagic-0.2.2.ebuild,v 1.1 2010/08/08 10:59:58 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README TODO info/filemagic.rd info/example.rb"

RUBY_FAKEGEM_TASK_TEST=""

inherit multilib ruby-fakegem

DESCRIPTION="Ruby binding to libmagic"
HOMEPAGE="http://ruby-filemagic.rubyforge.org/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

# Tests are broken. Reported upstream.
# http://rubyforge.org/tracker/index.php?func=detail&aid=24801&group_id=7000&atid=27124
RESTRICT="test"
#ruby_add_bdepend "test? ( virtual/ruby-test-unit )"

DEPEND="${DEPEND} sys-apps/file"
RDEPEND="${RDEPEND} sys-apps/file"

each_ruby_configure() {
	${RUBY} -Cext extconf.rb || die
}

each_ruby_compile() {
	emake -Cext || die
	mv ext/filemagic$(get_modname) lib/ || die
}

each_ruby_test() {
	${RUBY} -Ctest -Ilib filemagic_test.rb || die
}
