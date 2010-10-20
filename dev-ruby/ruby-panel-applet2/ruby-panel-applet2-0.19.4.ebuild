# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-panel-applet2/ruby-panel-applet2-0.19.4.ebuild,v 1.4 2010/10/20 22:00:01 ranger Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby Panel-applet bindings"
KEYWORDS="amd64 ~ia64 ppc ~sparc x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=gnome-base/gnome-panel-2.8
	=gnome-base/libgnome-2*
	=gnome-base/libgnomeui-2*"
DEPEND="${DEPEND}
	>=gnome-base/gnome-panel-2.8
	=gnome-base/libgnome-2*
	=gnome-base/libgnomeui-2*
	dev-util/pkgconfig"

ruby_add_rdepend ">=dev-ruby/ruby-gnome2-${PV}
	>=dev-ruby/ruby-glib2-${PV}
	>=dev-ruby/ruby-gtk2-${PV}"
