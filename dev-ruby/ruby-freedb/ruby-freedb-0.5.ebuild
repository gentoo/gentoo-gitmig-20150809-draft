# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-freedb/ruby-freedb-0.5.ebuild,v 1.1 2003/07/31 14:02:21 twp Exp $

DESCRIPTION="A Ruby library to access cddb/freedb servers"
HOMEPAGE="http://davedd.free.fr/ruby-freedb/"
SRC_URI="http://davedd.free.fr/ruby-freedb/download/${P}.tar.gz"
LICENSE="GPL-2 Artistic"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc ~x86"
IUSE=""
DEPEND=">=dev-lang/ruby-1.6.8"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	einstall || die
	dodoc CHANGELOG README
	dohtml -r doc/*
}
