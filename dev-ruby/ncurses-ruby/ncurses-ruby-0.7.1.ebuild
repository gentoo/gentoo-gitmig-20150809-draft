# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ncurses-ruby/ncurses-ruby-0.7.1.ebuild,v 1.1 2003/07/07 21:56:06 twp Exp $

DESCRIPTION="Ruby wrappers of ncurses and PDCurses libs"
HOMEPAGE="http://ncurses-ruby.berlios.de/"
SRC_URI="http://download.berlios.de/ncurses-ruby/${P}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc ~x86"
IUSE=""
DEPEND=">=dev-lang/ruby-1.6
	>=sys-libs/ncurses-5.3"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	einstall
}
