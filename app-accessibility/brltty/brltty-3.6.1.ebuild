# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/brltty/brltty-3.6.1.ebuild,v 1.10 2005/07/03 15:47:41 plasmaroo Exp $

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="daemon that provides access to the Linux/Unix console for a blind person"
HOMEPAGE="http://mielke.cc/brltty/"
SRC_URI="http://mielke.cc/brltty/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="gpm X usb"

DEPEND="virtual/libc
	gpm? ( >=sys-libs/gpm-1.20 )
	X? ( virtual/x11 )"

src_compile() {
	econf `use_enable gpm` \
		`use_with X x` \
		`use_enable usb usb-support` \
		--prefix=/ \
		--includedir=/usr/include || die
	make || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die
}
