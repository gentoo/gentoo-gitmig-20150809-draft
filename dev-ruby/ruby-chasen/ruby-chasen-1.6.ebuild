# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-chasen/ruby-chasen-1.6.ebuild,v 1.2 2004/08/03 11:34:15 dholm Exp $

inherit ruby

MY_P="${PN/ruby-}${PV}"
DESCRIPTION="ChaSen module for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=ruby-chasen"
SRC_URI="http://www.itlb.te.noda.sut.ac.jp/~ikarashi/ruby/${MY_P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

DEPEND="virtual/ruby
	>=app-text/chasen-2.3.3-r2"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf -L/usr/lib
	sed -i -e '/^LIBS/s/$/ -lstdc++/' Makefile || die
	emake
}
