# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-print/gtklp/gtklp-0.9k.ebuild,v 1.1 2002/07/25 22:53:42 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A GUI for cupsd"
SRC_URI="http://www.stud.uni-hannover.de/~sirtobi/gtklp/files/${P}.src.tar.gz"
HOMEPAGE="http://www.stud.uni-hannover.de/~sirtobi/gtklp"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc 
	=x11-libs/gtk+-1.2*
	>=net-print/cups-1.1.7"
RDEPEND="${DEPEND}"
src_unpack() {
    unpack ${P}.src.tar.gz
}


src_compile() {
	local myconf=""
	use nls && myconf="${myconf} --enable-nls"
        use nls || myconf="${myconf} --disable-nls"
       	use ssl && myconf="${myconf} --enable-ssl"
        use ssl || myconf="${myconf} --disable-ssl"
       
	./configure	--host=${CHOST}                 \
		        --infodir=/usr/share/info 	\
	    		--mandir=/usr/share/man 	\
			${myconf}			\
	    		--prefix=/usr              || die    
	emake ||die
}

src_install () {
    make DESTDIR=${D} install || die
    dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS
}

