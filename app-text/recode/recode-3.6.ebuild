# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/recode/recode-3.6.ebuild,v 1.6 2002/08/23 22:13:05 azarah Exp $

inherit flag-o-matic

replace-flags "-march=pentium4" "-march=pentium3"

S=${WORKDIR}/${P}
DESCRIPTION="Convert files between various character sets."
SRC_URI="ftp://gnu.wwc.edu/recode/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )"

RDEPEND="${DEPEND}"

KEYWORDS="x86 sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

src_compile() {

	local myconf=""
	use nls || myconf="--disable-nls"
        
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		$myconf || die
			
	emake || die
}

src_install() {
	
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc AUTHORS BACKLOG COPYING* ChangeLog INSTALL
	dodoc NEWS README THANKS TODO
}

