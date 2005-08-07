# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/numlockx/numlockx-1.0.ebuild,v 1.19 2005/08/07 12:57:05 hansmi Exp $

DESCRIPTION="Turns on numlock in X"
HOMEPAGE="http://ktown.kde.org/~seli/numlockx/"
SRC_URI="http://ktown.kde.org/~seli/numlockx/${P}.tar.gz"

SLOT="0"
LICENSE="EDB"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/x11"

src_install(){
	dobin numlockx

	dodoc AUTHORS INSTALL LICENSE README
}

pkg_postinst(){
	einfo
	einfo "add 'numlockx' to your X startup programs to have numlock turn on when X starts"
	einfo
}
