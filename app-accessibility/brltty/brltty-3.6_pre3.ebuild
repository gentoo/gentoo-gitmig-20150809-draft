# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/brltty/brltty-3.6_pre3.ebuild,v 1.1 2004/09/18 05:04:28 squinky86 Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="daemon that provides access to the Linux/Unix console for a blind person"
HOMEPAGE="http://mielke.cc/brltty/"
SRC_URI="http://mielke.cc/brltty/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64 ~ppc64"
IUSE="gpm X usb"

DEPEND="virtual/libc
	gpm? ( >=sys-libs/gpm-1.20 )
	X? ( virtual/x11 )"

src_compile() {
	econf `use_enable gpm` \
		`use_with X x` \
		`use_enable usb usb-support` || die
	make || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die
}
