# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtk2/ruby-gtk2-0.5.0.ebuild,v 1.5 2004/03/20 15:37:54 agriffis Exp $

DESCRIPTION="Ruby gtk+-2 bindings"
HOMEPAGE="http://ruby-gnome2.sourceforge.jp/"
SRC_URI="mirror://sourceforge/ruby-gnome2/${P}.tar.gz"
LICENSE="Ruby"
SLOT="0"
KEYWORDS="~alpha ~hppa ~mips ~ppc ~sparc x86"

DEPEND=">=dev-lang/ruby-1.6
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=x11-libs/pango-1.1"

src_compile() {
	ruby extconf.rb || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
