# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-svg/ruby-svg-1.0.3-r1.ebuild,v 1.3 2009/04/14 17:47:00 graaff Exp $

inherit ruby

DESCRIPTION="Ruby SVG Generator"
HOMEPAGE="http://ruby-svg.sourceforge.jp/"
SRC_URI="http://downloads.sourceforge.jp/ruby-svg/2288/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
USE_RUBY="ruby18"
IUSE="examples"
DEPEND="virtual/ruby
	dev-ruby/rdtool"
RDEPEND="virtual/ruby"

src_install() {
	ruby install.rb config --prefix="${D}"/usr || die
	ruby install.rb setup || die
	ruby install.rb install || die

	rd2 README.en.rd > README.en.html
	rd2 README.ja.rd > README.ja.html

	dohtml *.html || die

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		doins sample/*
	fi
}
