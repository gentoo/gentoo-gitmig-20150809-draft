# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/term-ansicolor/term-ansicolor-1.0.4-r1.ebuild,v 1.3 2010/01/14 16:08:46 ranger Exp $

EAPI=2
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Small Ruby library that colors strings using ANSI escape sequences."
HOMEPAGE="http://term-ansicolor.rubyforge.org/"
LICENSE="GPL-2"

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
SLOT="0"
IUSE="examples"

all_ruby_install() {
	dodoc CHANGES doc-main.txt README

	use examples && docinto examples && dodoc examples/*
}
