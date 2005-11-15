# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-panel-applet2/ruby-panel-applet2-0.14.1.ebuild,v 1.1 2005/11/15 10:54:47 citizen428 Exp $

inherit ruby ruby-gnome2

DESCRIPTION="Ruby Panel-applet bindings"
KEYWORDS="~x86"
IUSE=""
USE_RUBY="ruby18 ruby19"
DEPEND=">=gnome-base/gnome-panel-2.8
	=gnome-base/libgnome-2*
	=gnome-base/libgnomeui-2*"

RDEPEND="${DEPEND}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"
