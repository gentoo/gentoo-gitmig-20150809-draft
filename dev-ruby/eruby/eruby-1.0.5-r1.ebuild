# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/eruby/eruby-1.0.5-r1.ebuild,v 1.3 2006/12/20 18:55:16 jer Exp $

inherit ruby

IUSE="vim-syntax"

DESCRIPTION="eRuby interprets a Ruby code embedded text file"
HOMEPAGE="http://www.modruby.net/"
SRC_URI="http://www.modruby.net/archive/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 ~mips ~ppc sparc x86"
DEPEND="virtual/ruby"
PDEPEND="vim-syntax? ( app-vim/eruby-syntax )"
USE_RUBY="ruby16 ruby18"	# doesn't build on ruby19

src_compile() {
	ruby configure.rb || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog README*
}
