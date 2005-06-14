# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/numlockx/numlockx-1.0.ebuild,v 1.17 2005/06/14 01:39:36 smithj Exp $

DESCRIPTION="Turns on numlock in X"
HOMEPAGE="http://ktown.kde.org/~seli/numlockx/"
SRC_URI="http://ktown.kde.org/~seli/numlockx/${P}.tar.gz"

SLOT="0"
LICENSE="EDB"
KEYWORDS="x86 sparc amd64 ppc64 ~ppc"
IUSE=""

DEPEND="virtual/x11"


src_compile(){
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install(){
	into /usr
	dobin numlockx

	dodoc AUTHORS INSTALL LICENSE README
}

pkg_postinst(){
	einfo ""
	einfo "add 'numlockx' to your X startup programs to have numlock turn on when X starts"
	einfo ""
}
