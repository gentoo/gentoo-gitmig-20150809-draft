# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/narray/narray-0.5.9_p6.ebuild,v 1.10 2011/10/23 15:30:21 armin76 Exp $

MY_P=${P/_/}

DESCRIPTION="Numerical N-dimensional Array class"
HOMEPAGE="http://www.ir.isas.ac.jp/~masa/ruby/index-e.html"
SRC_URI="mirror://rubyforge/${PN}/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 hppa ~mips ppc ~ppc64 x86"

USE_RUBY="ruby18"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make exec_prefix=/usr DESTDIR="${D}" install || die
	dodoc ChangeLog README.* SPEC.*
}
