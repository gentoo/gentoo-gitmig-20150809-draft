# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/term-ansicolor/term-ansicolor-1.0.5-r1.ebuild,v 1.6 2010/11/13 19:12:12 armin76 Exp $

EAPI=2
USE_RUBY="ruby18 ree18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST="tests"
RUBY_FAKEGEM_EXTRADOC="CHANGES README"

# don't install a cdiff wrapper, collides with app-misc/colordiff (bug
# #310073).
RUBY_FAKEGEM_BINWRAP="decolor"

inherit ruby-fakegem

DESCRIPTION="Small Ruby library that colors strings using ANSI escape sequences."
HOMEPAGE="http://term-ansicolor.rubyforge.org/"
LICENSE="GPL-2"

KEYWORDS="amd64 ~hppa ia64 ~ppc ~ppc64 sparc x86"
SLOT="0"
IUSE="examples"

all_ruby_install() {
	all_fakegem_install

	use examples && docinto examples && dodoc examples/*
}
