# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtk/ruby-gtk-0.34-r1.ebuild,v 1.4 2004/03/13 22:06:20 dholm Exp $

inherit ruby-gnome2 ruby

S=${WORKDIR}/ruby-gnome-all-${PV}/gtk
DESCRIPTION="Ruby Gtk+ bindings"
HOMEPAGE="http://ruby-gnome.sourceforge.net/"
SRC_URI="mirror://sourceforge/ruby-gnome/ruby-gnome-all-${PV}.tar.gz"

LICENSE="Ruby"
SLOT="0"
USE_RUBY="ruby16 ruby18"
KEYWORDS="~x86 alpha ~sparc ~ppc"

DEPEND=">=dev-lang/ruby-1.6.8-r2
	=x11-libs/gtk+-1.2*"
