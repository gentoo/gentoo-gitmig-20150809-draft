# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/raggle/raggle-0.1.3.ebuild,v 1.1 2003/07/22 14:31:33 twp Exp $

DESCRIPTION="A console RSS aggregator, written in Ruby"
HOMEPAGE="http://www.raggle.org/"
SRC_URI="http://www.raggle.org/files/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc ~x86"
IUSE=""
DEPEND="dev-lang/ruby
	dev-ruby/ruby-syck
	dev-ruby/rexml
	dev-ruby/ncurses-ruby"

src_install() {
	dobin raggle
	doman raggle.1
	dodoc AUTHORS BUGS ChangeLog README doc/*
	insinto /usr/share/raggle/themes
	doins themes/*
}
