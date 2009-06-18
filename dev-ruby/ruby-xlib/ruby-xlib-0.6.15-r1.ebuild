# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-xlib/ruby-xlib-0.6.15-r1.ebuild,v 1.6 2009/06/18 18:31:38 graaff Exp $

inherit ruby
USE_RUBY="ruby18 ruby19"

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

PATCHES=( "${FILESDIR}/ruby-xlib-0.6.15-gcc.patch" )
