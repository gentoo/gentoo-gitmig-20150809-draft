# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/racc/racc-1.4.3-r1.ebuild,v 1.1 2003/06/10 23:01:33 twp Exp $

MY_P=${P}-all
DESCRIPTION="A LALR(1) parser generator for Ruby"
HOMEPAGE="http://www.loveruby.net/en/racc.html"
SRC_URI="http://www.loveruby.net/archive/racc/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha arm hppa mips sparc x86"
IUSE=""
S=${WORKDIR}/${MY_P}

DEPEND=">=dev-lang/ruby-1.6.1
        >=dev-ruby/amstd-1.9.5
		>=dev-ruby/strscan-0.6.5"

src_compile() {
	ruby setup.rb config --without=amstd,strscan || die
	ruby setup.rb setup || die
}

src_install () {
	ruby setup.rb config --prefix=${D}/usr --without=amstd,strscan || die
	ruby setup.rb install || die
}
