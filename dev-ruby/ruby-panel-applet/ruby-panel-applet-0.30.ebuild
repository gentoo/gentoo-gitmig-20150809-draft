# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-panel-applet/ruby-panel-applet-0.30.ebuild,v 1.4 2004/01/09 14:46:56 agriffis Exp $

S=${WORKDIR}/ruby-gnome-all-${PV}/panel-applet
DESCRIPTION="Ruby Gnome Panel bindings"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
SRC_URI="mirror://sourceforge/ruby-gnome/ruby-gnome-all-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86 alpha"

DEPEND=">=dev-lang/ruby-1.6.4-r1
	>=dev-ruby/ruby-gnome-${PV}"

src_compile() {
	ruby extconf.rb || die "ruby extconf.rb failed"
	emake || die "emake failed"
}

src_install() {
	make site-install DESTDIR=${D}
	dodoc [A-Z]*
	cp -dr sample ${D}/usr/share/doc/${PF}
}
