# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtk/ruby-gtk-0.34-r1.ebuild,v 1.5 2004/04/11 15:11:05 usata Exp $

inherit ruby-gnome2 ruby

S=${WORKDIR}/ruby-gnome-all-${PV}/gtk
DESCRIPTION="Ruby Gtk+ bindings"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
SRC_URI="mirror://sourceforge/ruby-gnome/ruby-gnome-all-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
USE_RUBY="ruby16 ruby18"	# ruby19 is not supported yet
KEYWORDS="~x86 alpha ~sparc ~ppc"

DEPEND="virtual/ruby
	=x11-libs/gtk+-1.2*"
