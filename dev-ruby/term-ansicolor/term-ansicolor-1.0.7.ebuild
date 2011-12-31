# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/term-ansicolor/term-ansicolor-1.0.7.ebuild,v 1.3 2011/12/31 18:08:03 grobian Exp $

EAPI=2
USE_RUBY="ruby18 ree18 jruby ruby19 rbx"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="none"
RUBY_FAKEGEM_EXTRADOC="CHANGES README.rdoc"

RUBY_FAKEGEM_GEMSPEC="term-ansicolor.gemspec"

# don't install a cdiff wrapper, collides with app-misc/colordiff (bug
# #310073).
RUBY_FAKEGEM_BINWRAP="decolor"

inherit ruby-fakegem

DESCRIPTION="Small Ruby library that colors strings using ANSI escape sequences."
HOMEPAGE="http://term-ansicolor.rubyforge.org/"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
SLOT="0"
IUSE="examples"

each_ruby_test() {
	${RUBY} -Ilib tests/ansicolor_test.rb || die
}

all_ruby_install() {
	all_fakegem_install

	use examples && docinto examples && dodoc examples/*
}
