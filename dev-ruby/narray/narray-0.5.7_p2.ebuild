# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/narray/narray-0.5.7_p2.ebuild,v 1.8 2005/03/25 13:55:44 blubb Exp $

inherit ruby

MY_P=${P/_/}

DESCRIPTION="Numerical N-dimensional Array class"
HOMEPAGE="http://www.ir.isas.ac.jp/~masa/ruby/index-e.html"
SRC_URI="http://www.ir.isas.ac.jp/~masa/ruby/dist/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha hppa mips ~ppc sparc x86"

IUSE=""
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="virtual/ruby"

S="${WORKDIR}/${MY_P}"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	local ARCHDIR=`ruby -r rbconfig -e 'print Config::CONFIG["archdir"]'`
	einstall hdrdir=${ARCHDIR} || die

	dodoc ChangeLog README.* SPEC.*
}
