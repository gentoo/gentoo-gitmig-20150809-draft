# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amrita/amrita-1.8.2.ebuild,v 1.8 2004/04/10 06:49:07 usata Exp $

DESCRIPTION="A HTML/XHTML template library for Ruby"
HOMEPAGE="http://www.brain-tokyo.jp/research/amrita/index.html"
SRC_URI="http://www.brain-tokyo.jp/research/amrita/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~alpha hppa ~mips sparc x86"
IUSE=""
DEPEND="|| ( >=dev-lang/ruby-1.8.0
	dev-ruby/shim-ruby18
	dev-lang/ruby-cvs )"

src_compile() {
	ruby install.rb config --prefix=/usr || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install || die
	dodoc ChangeLog README* RELEASENOTE
	dohtml -r docs/html/*
}
