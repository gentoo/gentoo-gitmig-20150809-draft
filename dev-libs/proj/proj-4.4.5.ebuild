# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-libs/proj/proj-4.4.5.ebuild,v 1.2 2003/02/13 10:50:15 vapier Exp $

IUSE=""

S="${WORKDIR}/${P}"

DESCRIPTION="cartographic projections library"
SRC_URI="ftp://ftp.remotesensing.org/pub/proj/${P}.tar.gz"
HOMEPAGE="http://www.remotesensing.org/proj/"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}

