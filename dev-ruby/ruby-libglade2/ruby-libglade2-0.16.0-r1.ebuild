# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-libglade2/ruby-libglade2-0.16.0-r1.ebuild,v 1.4 2008/04/07 21:26:18 klausman Exp $

inherit eutils ruby ruby-gnome2

DESCRIPTION="Ruby Libglade2 bindings"
KEYWORDS="alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="gnome"
USE_RUBY="ruby18 ruby19"
DEPEND=">=gnome-base/libglade-2
	dev-util/pkgconfig"
RDEPEND="${DEPEND}
	gnome? ( >=dev-ruby/ruby-gnome2-${PV} )
	!gnome? ( >=dev-ruby/ruby-gtk2-${PV} )
	>=dev-ruby/ruby-glib2-${PV}"

src_unpack() {
	ruby_src_unpack
	epatch "${FILESDIR}"/ruby-libglade2-0.16.0-upstreamfix.patch
}
