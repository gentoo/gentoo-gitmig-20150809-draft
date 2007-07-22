# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-xlib/ruby-xlib-0.6.15-r1.ebuild,v 1.4 2007/07/22 07:06:00 graaff Exp $

inherit ruby
USE_RUBY="ruby16 ruby18 ruby19"

DESCRIPTION="call Xlib functions from ruby"
HOMEPAGE="http://www.moriq.com/ruby/xlib/"
SRC_URI="http://www.moriq.com/ruby/archive/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xextproto"

PATCHES="${FILESDIR}/ruby-xlib-0.6.15-gcc.patch"

src_install() {
	ruby_src_install
	find ${D}/usr/share/doc/${PF} -perm 666 -print0 | xargs -0 chmod 644
}
