# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Einar Karttunen <ekarttun@cs.helsinki.fi>
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libglade/ruby-libglade-1.2.ebuild,v 1.1 2002/05/27 10:23:03 seemant Exp $

MY_P=${PN}-${PV/./-}
S=${WORKDIR}/${PN}
DESCRIPTION="Ruby libglade bindings"
SRC_URI="http://beta4.com/${MY_P}.tar.gz"
HOMEPAGE="http://www.ruby-lang.org/en/raa-list.rhtml?name=Ruby%2FLibGlade"

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
