## Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-libs/aalib/aalib-1.4_rc4-r1.ebuild,v 1.2 2002/05/27 17:27:38 drobbins Exp $

MY_P=${P/_/}
S=${WORKDIR}/${PN}-1.4.0
DESCRIPTION="A ASCI-Graphics Library"
SRC_URI="mirror://sourceforge/aa-project/${MY_P}.tar.gz"
HOMEPAGE="http://www.ta.jcu.cz/aa/"

DEPEND=">=sys-libs/ncurses-5.1
	slang? ( >=sys-libs/slang-1.4.2 )
	X?     ( virtual/x11 )
	gpm?   ( sys-libs/gpm )"

RDEPEND=">=sys-libs/ncurses-5.1
	slang? ( >=sys-libs/slang-1.4.2 )
	X?     ( virtual/x11 )
	gpm?   ( sys-libs/gpm )"


src_unpack() {

	unpack ${A}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die
	touch *

        #crude libtool version fix
        cp -f `which libtool` ${S}
        touch ${S}/*
}

src_compile() {

	local myconf
	if [ "`use slang`" ]
	then
		myconf="--with-slang-driver=yes"
	else
		myconf="--with-slang-driver=no"
	fi
	
	if [ "`use X`" ]
	then
		myconf="${myconf} --with-x11-driver=yes"
	else
		myconf="${myconf} --with-x11-driver=no"
	fi
	
	if [ -z "`use gpm`" ]
	then
		myconf="${myconf} --with-gpm-mouse=no"
	fi

	./configure --prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=${D}/usr/share/man \
		--host=${CHOST} \
		${myconf} || die
		
	emake || die
}

src_install() {

	make prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		mandir=${D}/usr/share/man \
		install || die

	dodoc ANNOUNCE AUTHORS ChangeLog COPYING NEWS README*
}

