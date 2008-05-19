# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libglade2/ruby-libglade2-0.16.0-r1.ebuild,v 1.9 2008/05/19 05:28:38 graaff Exp $

inherit eutils ruby ruby-gnome2

DESCRIPTION="Ruby Libglade2 bindings"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="gnome"
USE_RUBY="ruby18 ruby19"
RDEPEND="
	>=gnome-base/libglade-2
	gnome? ( >=dev-ruby/ruby-gnome2-${PV} )
	!gnome? ( >=dev-ruby/ruby-gtk2-${PV} )
	>=dev-ruby/ruby-glib2-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	ruby_src_unpack
	epatch "${FILESDIR}"/ruby-libglade2-0.16.0-upstreamfix.patch
}
