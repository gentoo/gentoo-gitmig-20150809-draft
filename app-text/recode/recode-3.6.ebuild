# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer:  Desktop Team <desktop@cvs.gentoo.org>
# Author:  Martin Schlemmer <azarah@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="Convert files between various character sets."
SRC_URI="ftp://gnu.wwc.edu/recode/recode-3.6.tar.gz"
HOMEPAGE="http://www.gnu.org/"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )"
	

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

