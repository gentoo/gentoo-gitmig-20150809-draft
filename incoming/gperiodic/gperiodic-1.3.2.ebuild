# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Tod Neidt <tneidt@fidnet.com>
# /home/cvsroot/gentoo-x86/skel.build,v 1.7 2001/08/25 21:15:08 chadh Exp


S=${WORKDIR}/${P}

DESCRIPTION="GPeriodic is a periodic table application for Linux."

SRC_URI="ftp://ftp.seul.org/pub/gperiodic/${P}.tar.gz"

HOMEPAGE="http://gperiodic.seul.org/"

DEPEND=">=sys-libs/ncurses-5.2
		>=x11-libs/gtk+-1.2.1
		nls? ( sys-devel/gettext )"


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

	./configure --infodir=/usr/share/info --mandir=/usr/share/man \
				--prefix=/usr --host=${CHOST} ${myconf} || die
	
	emake || die

}

src_install () {

	make prefix=${D}/usr install || die
	
	doman man/gperiodic.1
	
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README

}

