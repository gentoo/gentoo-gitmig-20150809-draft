# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/racc/racc-1.4.1.ebuild,v 1.1 2002/08/18 00:43:41 agriffis Exp $

S=${WORKDIR}/${P}-all
DESCRIPTION="LALR parser generator for Ruby"
SRC_URI="http://www.loveruby.net/archive/racc/${P}-all.tar.gz"
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
	# It appears that this reconfig doesn't hurt anything.
	# The --prefix and --rb-dir args don't work on the install line.
	ruby setup.rb config \
		--prefix=${D}/usr \
		--rb-dir=${D}/usr/lib/ruby/site_ruby/1.6 || die
	ruby setup.rb install || die
}
