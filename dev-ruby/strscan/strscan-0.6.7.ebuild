# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/strscan/strscan-0.6.7.ebuild,v 1.2 2003/05/07 17:47:41 twp Exp $

DESCRIPTION="A library for fast scanning"
HOMEPAGE="http://i.loveruby.net/en/strscan.html"
SRC_URI="http://i.loveruby.net/archive/strscan/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha arm hppa mips ppc sparc x86"
DEPEND=">=dev-lang/ruby-1.6.8"

src_compile() {
	ruby install.rb config --prefix=/usr || die
	ruby install.rb setup || die
}

src_install() {
	ruby install.rb config --prefix=${D}/usr || die
	ruby install.rb install || die
	dodoc README.en doc.en/ChangeLog
	dohtml doc.en/umanual.html
}
