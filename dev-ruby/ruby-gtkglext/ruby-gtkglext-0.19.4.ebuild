# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gtkglext/ruby-gtkglext-0.19.4.ebuild,v 1.3 2010/08/01 09:53:25 hwoarang Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby GtkGLExt bindings"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~sparc x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=x11-libs/gtkglext-1.0.3
	>=x11-libs/gtk+-2"
DEPEND="${DEPEND}
	>=x11-libs/gtkglext-1.0.3
	>=x11-libs/gtk+-2
	dev-util/pkgconfig"

ruby_add_rdepend "dev-ruby/ruby-opengl
	dev-ruby/ruby-glib2
	dev-ruby/ruby-gtk2"
