# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/brltty/brltty-3.5.ebuild,v 1.6 2004/09/22 13:46:12 gustavoz Exp $

DESCRIPTION="daemon that provides access to the Linux/Unix console for a blind person"
HOMEPAGE="http://mielke.cc/brltty/"
SRC_URI="http://mielke.cc/brltty/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~mips alpha ~hppa ~amd64 ~ia64 ~ppc64"
IUSE="gpm"

DEPEND="virtual/libc
	gpm? ( >=sys-libs/gpm-1.20 )"

src_compile() {
	econf `use_enable gpm` || die
	make || die
}

src_install() {
	make INSTALL_ROOT=${D} install || die
}
