# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amrita/amrita-1.0.2.ebuild,v 1.2 2003/05/12 20:15:44 twp Exp $

DESCRIPTION="A HTML/XHTML template library for Ruby"
HOMEPAGE="http://www.brain-tokyo.jp/research/amrita/index.html"
SRC_URI="http://www.brain-tokyo.jp/research/amrita/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="alpha arm hppa mips sparc x86"
DEPEND=">=dev-lang/ruby-1.6.7
	>=dev-ruby/strscan-0.6.5"

src_install() {
	local sitelibdir=`ruby -r rbconfig -e 'print(Config::CONFIG["sitelibdir"])'`
	ruby install.rb --destdir=${D}/${sitelibdir} || die
	dodoc ChangeLog README*
	dohtml -r docs/html/*
}
