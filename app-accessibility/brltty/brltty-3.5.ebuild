# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/brltty/brltty-3.5.ebuild,v 1.14 2006/09/29 02:25:27 wormo Exp $

DESCRIPTION="daemon that provides access to the Linux/Unix console for a blind person"
HOMEPAGE="http://mielke.cc/brltty/"
SRC_URI="http://mielke.cc/brltty/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86"
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
