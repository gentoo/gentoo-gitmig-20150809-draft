# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/recode/recode-3.5.ebuild,v 1.11 2003/06/28 16:00:37 mholzer Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Convert files between various character sets."
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/recode/"
KEYWORDS="x86 sparc "

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"
        
	./configure --host=${CHOST}				\
		--prefix=/usr			  		\
		--mandir=/usr/share/man				\
		--infodir=/usr/share/info			\
		$myconf || die
			
	emake || die
}

src_install() {
	
	make prefix=${D}/usr					\
		mandir=${D}/usr/share/man			\
		infodir=${D}/usr/share/info			\
		install || die

	dodoc AUTHORS BACKLOG COPYING* ChangeLog INSTALL
	dodoc NEWS README THANKS TODO
}

