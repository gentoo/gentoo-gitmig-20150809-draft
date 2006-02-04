# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnome/ruby-gnome-0.30.ebuild,v 1.10 2006/02/04 15:06:47 solar Exp $

S=${WORKDIR}/ruby-gnome-all-${PV}/gnome
DESCRIPTION="Ruby Gnome bindings"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
SRC_URI="mirror://sourceforge/ruby-gnome/ruby-gnome-all-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="x86 alpha"
IUSE=""

DEPEND="virtual/ruby
	>=gnome-base/gnome-libs-1.4.1.3
	>=dev-ruby/ruby-gdkimlib-${PV}
	>=dev-ruby/ruby-gtk-${PV}"

src_compile() {
	ruby extconf.rb || die "ruby extconf.rb failed"
	emake || die "emake failed"
}

src_install() {
	make site-install DESTDIR=${D} || die "make site-install failed"
	dodoc [A-Z]*
	cp -r sample doc ${D}/usr/share/doc/${PF}
}
