# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libart/ruby-libart-0.34.ebuild,v 1.1 2003/08/06 01:52:32 agriffis Exp $

S=${WORKDIR}/ruby-gnome-all-${PV}/libart
DESCRIPTION="Ruby libart bindings"
SRC_URI="mirror://sourceforge/ruby-gnome/ruby-gnome-all-${PV}.tar.gz"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
LICENSE="Ruby"
KEYWORDS="~x86 ~alpha"
SLOT="0"

DEPEND=">=dev-lang/ruby-1.6.4-r1
		>=media-libs/libart_lgpl-2.3.10"

src_compile() {
	ruby extconf.rb || die "ruby extconf.rb failed"
	emake || die "emake failed"
}

src_install () {
	make site-install DESTDIR=${D}
	dodoc [A-Z]*
	cp -dr sample doc ${D}/usr/share/doc/${PF}
}
