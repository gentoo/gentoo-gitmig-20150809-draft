# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/racc/racc-1.2.4.ebuild,v 1.6 2002/08/01 11:59:01 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="LALR parser generator for Ruby"
SRC_URI="http://www1.u-netsurf.ne.jp/~brew/mine/soft/${P}.tar.gz"
HOMEPAGE="http://www1.u-netsurf.ne.jp/~brew/mine/en/index.html"
LICENSE="LGPL"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=dev-lang/ruby-1.6.1
        >=dev-ruby/amstd-1.9.5"

src_compile() {
	ruby setup.rb config --without=amstd || die
	ruby setup.rb setup || die
}

src_install () {
	ruby setup.rb install 						\
	     --bin-dir=${D}/usr/bin 					\
	     --rb-dir=${D}/usr/lib/ruby/site_ruby/1.6 			\
	     --so-dir=${D}/usr/lib/ruby/site_ruby/1.6/${CHOST%%-*}-linux-gnu
	assert
}
