# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-xlib/ruby-xlib-0.6.15-r1.ebuild,v 1.1 2006/02/16 19:00:54 twp Exp $

inherit ruby
USE_RUBY="ruby16 ruby18 ruby19"

DESCRIPTION="call Xlib functions from ruby"
HOMEPAGE="http://www.moriq.com/ruby/xlib/"
SRC_URI="http://www.moriq.com/ruby/archive/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	|| (
		(
			x11-libs/libX11
			x11-libs/libXext
		)
		virtual/x11
	)"
DEPEND="${RDEPEND}
	|| (
		(
			x11-proto/xproto
			x11-proto/xextproto
		)
		virtual/x11
	)"

PATCHES="${FILESDIR}/ruby-xlib-0.6.15-gcc.patch"

src_install() {
	ruby_src_install
	find ${D}/usr/share/doc/${PF} -perm 666 -print0 | xargs -0 chmod 644
}
