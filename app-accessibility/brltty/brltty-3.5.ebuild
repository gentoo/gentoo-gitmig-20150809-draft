# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/brltty/brltty-3.5.ebuild,v 1.1 2004/06/15 03:05:10 squinky86 Exp $

IUSE="gpm"

DESCRIPTION="BRLTTY is a background process (daemon) which provides access to the Linux/Unix console (when in text mode) for a blind person "
HOMEPAGE="http://mielke.cc/brltty"
SRC_URI="http://mielke.cc/brltty/releases/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64 ~ppc64"

DEPEND="virtual/glibc
	gpm? ( >=sys-libs/gpm-1.20 )"

src_compile() {
	econf \
		`use_enable gpm` || die
	make || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die
}
