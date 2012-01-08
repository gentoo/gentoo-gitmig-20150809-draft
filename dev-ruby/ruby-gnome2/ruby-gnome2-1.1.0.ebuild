# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnome2/ruby-gnome2-1.1.0.ebuild,v 1.1 2012/01/08 06:56:29 naota Exp $

EAPI="2"
USE_RUBY="ruby18 ruby19"

inherit ruby-ng

DESCRIPTION="Ruby Gnome2 bindings"
HOMEPAGE="http://ruby-gnome2.sourceforge.jp/"
SRC_URI=""

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2"
DEPEND="${DEPEND}
	>=gnome-base/libgnome-2.2
	>=gnome-base/libgnomeui-2.2"

ruby_add_rdepend ">=dev-ruby/ruby-gio2-${PV}
	>=dev-ruby/ruby-goocanvas-${PV}
	>=dev-ruby/ruby-gstreamer-${PV}
	>=dev-ruby/ruby-gtk2-${PV}
	>=dev-ruby/ruby-gtksourceview-${PV}
	>=dev-ruby/ruby-poppler-${PV}
	>=dev-ruby/ruby-rsvg-${PV}
	>=dev-ruby/ruby-vte-${PV}"
