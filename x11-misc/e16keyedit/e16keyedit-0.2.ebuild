# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e16keyedit/e16keyedit-0.2.ebuild,v 1.10 2003/02/13 17:12:00 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Key binding editor for enlightenment 16"
SRC_URI="ftp://ftp.enlightenment.org/enlightenment/e16utils/${P}.tar.gz"
HOMEPAGE="http://www.enlightenment.org"
LICENSE="as-is"
DEPEND="virtual/x11
		>=x11-wm/enlightenment-0.16"
SLOT="0"
KEYWORDS="x86 sparc "

#RDEPEND=""

src_compile() {
	
	emake || die
}

src_install () {
	
	 dobin e16keyedit
	 dodoc README COPYING ChangeLog AUTHORS
}

