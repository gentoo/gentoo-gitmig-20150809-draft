# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkglext/ruby-gtkglext-0.8.0.ebuild,v 1.4 2004/07/04 17:09:26 usata Exp $

inherit ruby-gnome2

DESCRIPTION="Ruby GtkGLExt bindings"
KEYWORDS="~alpha x86"	# ia64 is not tested on ruby-opengl
DEPEND="virtual/ruby
	>=x11-libs/gtkglext-1.0.3
	>=x11-libs/gtk+-2
	dev-ruby/ruby-opengl
	dev-ruby/ruby-glib2
	dev-ruby/ruby-gtk2"
