# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gconf/ruby-gconf-0.2.ebuild,v 1.11 2004/04/16 23:47:51 dholm Exp $

inherit ruby

DESCRIPTION="Ruby Gconf bindings"
SRC_URI="mirror://sourceforge/ruby-gnome/${P}.tar.gz"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
LICENSE="Ruby"
KEYWORDS="x86 ~ppc"
USE_RUBY="ruby16 ruby18 ruby19"
SLOT="0"

DEPEND="virtual/ruby
	=x11-libs/gtk+-1.2*
	>=gnome-base/gconf-1.0.7-r2"

src_compile() {
	ruby extconf.rb || die "ruby extconf.rb failed"
	emake || die "emake failed"
}

src_install () {
	make -C src install DESTDIR=${D}
	dodoc [A-Z]*
}
