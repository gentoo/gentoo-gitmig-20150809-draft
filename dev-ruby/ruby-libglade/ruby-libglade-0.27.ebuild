# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libglade/ruby-libglade-0.27.ebuild,v 1.1 2002/04/22 01:07:15 agriffis Exp $

S=${WORKDIR}/ruby-gnome-all-${PV}/libglade
DESCRIPTION="Ruby libglade bindings"
SRC_URI="http://prdownloads.sourceforge.net/ruby-gnome/ruby-gnome-all-${PV}.tar.gz"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"

DEPEND=">=dev-lang/ruby-1.6.4-r1
		>=x11-libs/gtk+-1.2.10-r4
		>=dev-libs/libxml-1.8.17-r2
		>=zlib-1.1.4"

src_compile() {
	ruby extconf.rb || die "ruby extconf.rb failed"
	emake || die "emake failed"
}

src_install () {
	make site-install DESTDIR=${D}
	dodoc [A-Z]*
	cp -dr sample ${D}/usr/share/doc/${PF}
}
