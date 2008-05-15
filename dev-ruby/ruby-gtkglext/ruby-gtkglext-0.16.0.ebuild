# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkglext/ruby-gtkglext-0.16.0.ebuild,v 1.7 2008/05/15 20:46:47 maekke Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby GtkGLExt bindings"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=x11-libs/gtkglext-1.0.3
	>=x11-libs/gtk+-2"
RDEPEND="dev-ruby/ruby-opengl
	dev-ruby/ruby-glib2
	dev-ruby/ruby-gtk2"
DEPEND="${DEPEND}
	dev-util/pkgconfig"
