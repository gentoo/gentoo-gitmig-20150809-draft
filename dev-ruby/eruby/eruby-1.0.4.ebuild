# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Maintaner: Tools Team <tools@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/eruby/eruby-1.0.4.ebuild,v 1.5 2004/06/25 01:53:27 agriffis Exp $

DESCRIPTION="eRuby interprets a Ruby code embedded text file"
HOMEPAGE="http://www.modruby.net/"
SRC_URI="http://www.modruby.net/archive/${P}.tar.gz"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha hppa mips sparc x86"
DEPEND="virtual/ruby"

src_compile() {
	ruby configure.rb || die
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog README*
}
