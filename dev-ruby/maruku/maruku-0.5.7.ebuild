# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/maruku/maruku-0.5.7.ebuild,v 1.1 2007/10/07 06:11:17 agorf Exp $

inherit ruby gems

DESCRIPTION="A Markdown-superset interpreter written in Ruby."
HOMEPAGE="http://maruku.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-ruby/syntax-1.0.0
		>=dev-lang/ruby-1.8.3"
RDEPEND="${DEPEND}"

pkg_postinst() {
	elog
	elog "You need to emerge app-text/tetex and dev-tex/latex-unicode if"
	elog "you want to use --pdf with Maruku. You may also want to emerge"
	elog "dev-tex/listings to enable LaTeX syntax highlighting."
	elog
}
