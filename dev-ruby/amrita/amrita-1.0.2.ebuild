# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amrita/amrita-1.0.2.ebuild,v 1.5 2004/04/10 06:49:07 usata Exp $

inherit ruby

DESCRIPTION="A HTML/XHTML template library for Ruby"
HOMEPAGE="http://www.brain-tokyo.jp/research/amrita/index.html"
SRC_URI="http://www.brain-tokyo.jp/research/amrita/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha hppa mips sparc x86"
USE_RUBY="ruby16 ruby18 ruby19"
DEPEND="|| ( >=dev-lang/ruby-1.8
	dev-ruby/shim-ruby18
	dev-lang/ruby-cvs )"

src_install() {
	local sitelibdir=`ruby -r rbconfig -e 'print(Config::CONFIG["sitelibdir"])'`
	ruby install.rb --destdir=${D}/${sitelibdir} || die
	dodoc ChangeLog README*
	dohtml -r docs/html/*
}
