# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libglade/ruby-libglade-0.29.ebuild,v 1.8 2004/04/11 15:52:48 usata Exp $

S=${WORKDIR}/ruby-gnome-all-${PV}/libglade
DESCRIPTION="Ruby libglade bindings"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
SRC_URI="mirror://sourceforge/ruby-gnome/ruby-gnome-all-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/ruby
	=x11-libs/gtk+-1.2*
	>=dev-libs/libxml-1.8.17-r2
	>=sys-libs/zlib-1.1.4"

src_compile() {
	ruby extconf.rb || die "ruby extconf.rb failed"
	emake || die "emake failed"
}

src_install() {
	make site-install DESTDIR=${D}
	dodoc [A-Z]*
	cp -dr sample ${D}/usr/share/doc/${PF}
}
