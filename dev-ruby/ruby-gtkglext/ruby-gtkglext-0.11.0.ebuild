# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkglext/ruby-gtkglext-0.11.0.ebuild,v 1.1 2004/11/25 04:28:34 usata Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GtkGLExt bindings"
KEYWORDS="~alpha ~x86 ~ppc ~sparc" 	# dropped ~ia64
IUSE=""
DEPEND=">=x11-libs/gtkglext-1.0.3
	>=x11-libs/gtk+-2
	dev-ruby/ruby-opengl
	dev-ruby/ruby-glib2
	dev-ruby/ruby-gtk2"
USE_RUBY="ruby16 ruby18 ruby19"
