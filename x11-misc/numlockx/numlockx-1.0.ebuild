# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/numlockx/numlockx-1.0.ebuild,v 1.21 2005/11/01 13:20:40 nelchael Exp $

DESCRIPTION="Turns on numlock in X"
HOMEPAGE="http://ktown.kde.org/~seli/numlockx/"
SRC_URI="http://ktown.kde.org/~seli/numlockx/${P}.tar.gz"

SLOT="0"
LICENSE="EDB"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/x11"

src_install(){
	dobin numlockx
	dodoc AUTHORS LICENSE README
}

pkg_postinst(){
	einfo
	einfo "add 'numlockx' to your X startup programs to have numlock turn on when X starts"
	einfo
}
