# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/strscan/strscan-0.5.8.ebuild,v 1.10 2003/09/08 02:23:08 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Fast string scanning library for Ruby"
SRC_URI="http://www1.u-netsurf.ne.jp/~brew/mine/soft/${P}.tar.gz"
HOMEPAGE="http://www1.u-netsurf.ne.jp/~brew/mine/en/index.html"
LICENSE="LGPL-2.1"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=dev-lang/ruby-1.6.1
	>=dev-ruby/amstd-1.9.5"

src_compile() {
	ruby setup.rb config --without=amstd || die
	ruby setup.rb setup || die
}

src_install () {
	ruby setup.rb install --bin-dir=${D}/usr/bin 			\
	     --rb-dir=${D}/usr/lib/ruby/site_ruby/1.6 			\
	     --so-dir=${D}/usr/lib/ruby/site_ruby/1.6/${CHOST%%-*}-linux-gnu
	assert
}
