# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gconf/ruby-gconf-0.2.ebuild,v 1.7 2002/08/01 11:59:02 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Ruby Gconf bindings"
SRC_URI="mirror://sourceforge/ruby-gnome/${P}.tar.gz"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
LICENSE="Ruby"
KEYWORDS="x86"
SLOT="0"

DEPEND=">=dev-lang/ruby-1.6.4-r1
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
