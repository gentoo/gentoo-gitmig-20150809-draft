# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/amstd/amstd-2.0.0.ebuild,v 1.3 2003/02/28 16:54:59 liquidx Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Ruby utility collection by Minero Aoki"
SRC_URI="http://www.loveruby.net/archive/amstd/${P}.tar.gz"
HOMEPAGE="http://www.loveruby.net/en/amstd.html"
LICENSE="LGPL-2.1"
KEYWORDS="x86 alpha"
SLOT="0"

DEPEND=">=dev-lang/ruby-1.6.1"

src_compile() {
	ruby install.rb config || die
	ruby install.rb setup || die
}

src_install () {
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install
}
