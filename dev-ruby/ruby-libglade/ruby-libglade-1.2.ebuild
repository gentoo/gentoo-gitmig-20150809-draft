# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libglade/ruby-libglade-1.2.ebuild,v 1.4 2002/10/04 05:29:55 vapier Exp $

MY_P=${PN}-${PV/./-}
S=${WORKDIR}/${PN}
DESCRIPTION="Ruby libglade bindings"
SRC_URI="http://beta4.com/${MY_P}.tar.gz"
HOMEPAGE="http://www.ruby-lang.org/en/raa-list.rhtml?name=Ruby%2FLibGlade"
LICENSE="Ruby"
KEYWORDS="x86"
SLOT="0"

DEPEND="dev-lang/ruby
	dev-ruby/ruby-gtk
	dev-util/glade"

src_compile() {
	ruby extconf.rb || die "ruby extconf.rb failed"
	
	cp Makefile Makefile.orig
	sed "s:CPPFLAGS = :CPPFLAGS = -I/usr/include/libglade-1.0 :" \
		Makefile.orig > Makefile
	emake ${CPPFLAGS} || die "emake failed"
}

src_install () {
	einstall || die
	dodoc README
	dodoc sample/*
}
