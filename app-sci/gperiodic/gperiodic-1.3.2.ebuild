# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/gperiodic/gperiodic-1.3.2.ebuild,v 1.6 2002/08/01 11:40:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GPeriodic is a periodic table application for Linux."
SRC_URI="ftp://ftp.seul.org/pub/gperiodic/${P}.tar.gz"
HOMEPAGE="http://gperiodic.seul.org/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=sys-libs/ncurses-5.2
	=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )"

PROVIDE="app-misc/gperiodic"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

 	#Fix version number,comment out non-working lex inquiry
 	# to eliminate superfluous config error, and use ncurses for termcap 

	patch -p1 < ${FILESDIR}/${P}-gentoo.diff || die
}

src_compile() {
	local myconf

	if [ -z "`use nls`" ]
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
	    	    --infodir=/usr/share/info 				\
		    --mandir=/usr/share/man 				\
		    ${myconf} || die
	
	emake || die
}

src_install () {
	make prefix=${D}/usr						\
	     sysconfdir=${D}/etc					\
	     localstatedir=${D}/var/lib					\
	     infodir=${D}/usr/share/info				\
	     mandir=${D}/usr/share/man					\
	     install || die
	
	doman man/gperiodic.1
	
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README
}
