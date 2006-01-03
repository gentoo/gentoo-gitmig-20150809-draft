# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-art/gnome-art-0.2-r1.ebuild,v 1.2 2006/01/03 02:02:49 caleb Exp $

inherit ruby

DESCRIPTION="A collection of tools for managing art from the art.gnome.org website."
HOMEPAGE="http://www.miketech.net/gnome-art/"
SRC_URI="http://www.miketech.net/gnome-art/download/${P}.tar.gz"

USE_RUBY="ruby18"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${PN}

RDEPEND="virtual/ruby
		>=dev-ruby/ruby-gnome2-0.12.0
		>=dev-ruby/ruby-gnomecanvas2-0.12.0
		>=dev-ruby/ruby-gtk2-0.12.0
		>=dev-ruby/ruby-atk-0.12.0
		>=dev-ruby/ruby-glib2-0.12.0
		>=dev-ruby/ruby-pango-0.12.0
		>=dev-ruby/ruby-gdkpixbuf2-0.12.0
		>=dev-ruby/ruby-libart2-0.12.0
		>=dev-ruby/ruby-libglade2-0.12.0
		>=dev-ruby/ruby-gconf2-0.12.0"
DEPEND="virtual/ruby"

src_install(){
	cd gnome-splashscreen-manager
	ruby_einstall || die "installing gnome-splashscreen-manager failed"
	cd ../gnome-art
	ruby_einstall || die "installing gnome-art failed"

	dodoc README AUTHORS Changelog

	mkdir ${D}/usr/share/pixmaps
	cp ${D}/usr/share/${PN}/glade/pixmaps/gnome-graphics.png \
		${D}/usr/share/pixmaps

	insinto /usr/share/applications
	doins ${FILESDIR}/gnome-art.desktop
	doins ${FILESDIR}/gnome-splashscreen-manager.desktop
}
