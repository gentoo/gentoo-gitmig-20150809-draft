# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtk/ruby-gtk-0.34-r1.ebuild,v 1.12 2004/11/01 21:11:15 corsair Exp $

inherit ruby-gnome2 ruby

S=${WORKDIR}/ruby-gnome-all-${PV}/gtk
DESCRIPTION="Ruby Gtk+ bindings"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
SRC_URI="mirror://sourceforge/ruby-gnome/ruby-gnome-all-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
USE_RUBY="ruby16 ruby18 ruby19"
KEYWORDS="x86 alpha ~sparc ppc ~ppc64"
IUSE=""

DEPEND="virtual/ruby
	=x11-libs/gtk+-1.2*"

src_unpack() {

	unpack ${A}
	cd ${S}

	ruby -i -pe 'sub "PLATFORM","RUBY_PLATFORM"' \
		extconf.rb src/makedefconst.rb || "substitution failed"
}
