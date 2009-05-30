# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/maruku/maruku-0.6.0.ebuild,v 1.1 2009/05/30 08:40:57 graaff Exp $

inherit ruby gems

USE_RUBY="ruby18"

DESCRIPTION="A Markdown-superset interpreter written in Ruby."
HOMEPAGE="http://maruku.rubyforge.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-ruby/syntax-1.0.0
		>=dev-lang/ruby-1.8.3"
RDEPEND="${DEPEND}"

pkg_postinst() {
	elog
	elog "You need to emerge app-text/texlive and dev-tex/latex-unicode if"
	elog "you want to use --pdf with Maruku. You may also want to emerge"
	elog "dev-tex/listings to enable LaTeX syntax highlighting."
	elog
}
