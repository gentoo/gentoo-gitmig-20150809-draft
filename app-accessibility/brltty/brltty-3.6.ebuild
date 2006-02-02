# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/brltty/brltty-3.6.ebuild,v 1.7 2006/02/02 02:08:14 williamh Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="daemon that provides access to the Linux/Unix console for a blind person"
HOMEPAGE="http://mielke.cc/brltty/"
SRC_URI="http://mielke.cc/brltty/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc ~x86"
IUSE="gpm X usb"

RDEPEND="virtual/libc
	gpm? ( >=sys-libs/gpm-1.20 )
	X? ( || ( x11-libs/libXaw virtual/x11 ) )"
DEPEND="${RDEPEND}
	X? ( || ( x11-proto/xextproto virtual/x11 ) )"

src_compile() {
	econf `use_enable gpm` \
		`use_with X x` \
		`use_enable usb usb-support` || die
	make || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die
}
