# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/raggle/raggle-0.2.4.ebuild,v 1.2 2003/12/29 02:53:29 twp Exp $

DESCRIPTION="A console RSS aggregator, written in Ruby"
HOMEPAGE="http://www.raggle.org/"
SRC_URI="http://www.raggle.org/files/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64"
IUSE=""
DEPEND=">=dev-lang/ruby-1.8.0
	dev-ruby/ncurses-ruby"

src_install() {
	dobin raggle
	doman raggle.1
	dodoc AUTHORS BUGS ChangeLog README doc/*
	insinto /usr/share/raggle/themes
	doins themes/*
}
