# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mc/mc-4.6.0_pre1-r2.ebuild,v 1.1 2002/12/13 03:03:24 bcowan Exp $

IUSE="gpm nls samba ncurses X slang"

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="GNU Midnight Commander cli-based file manager"

HOMEPAGE="http://www.ibiblio.org/mc/"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/file/managers/${PN}/${MY_P}.tar.gz
	http://www.gentoo.org/~bcowan/${MY_P}-2002-11-07-15.diff.bz2"


DEPEND=">=sys-apps/e2fsprogs-1.19
	ncurses? ( >=sys-libs/ncurses-5.2-r5 )
	=dev-libs/glib-2*
	>=sys-libs/pam-0.72 
	gpm? ( >=sys-libs/gpm-1.19.3 )
	slang? ( >=sys-libs/slang-1.4.2 )
	samba? ( >=net-fs/samba-2.2.3a-r1 )
	X? ( virtual/x11 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -E -p1 < ${WORKDIR}/${MY_P}-2002-11-04-13.diff
}	

src_compile() {                           
	local myconf=""
	
	if ! use slang && ! use ncurses
	    then  
		myconf="${myconf} --with-screen=mcslang"
	    elif
		use ncurses && ! use slang
	    then 
		myconf="${myconf} --with-screen=ncurses"
	    else
		use slang && myconf="${myconf} --with-screen=slang"
	fi

	use gpm \
	    && myconf="${myconf} --with-gpm-mouse" \
	    || myconf="${myconf} --without-gpm-mouse"

	use nls \
	    && myconf="${myconf} --with-included-gettext" \
	    || myconf="${myconf} --disable-nls"
							
	use X \
	    && myconf="${myconf} --with-tm-x-support --with-x" \
	    || myconf="${myconf} --without-tm-x-support --without-x"
	
	use samba \
	    && myconf="${myconf} --with-samba --with-configdir=/etc/samba
				--with-codepagedir=/var/lib/samba/codepages" \
	    || myconf="${myconf} --without-samba"
 
	econf \
	    --with-glib2 \
	    --with-vfs \
	    --with-gnu-ld \
	    --with-ext2undel \
	    --with-edit \
	    ${myconf} || die
	emake || die
}

src_install() {                               
	einstall
	
	dodoc ABOUT-NLS COPYING* ChangeLog AUTHORS MAINTAINERS FAQ INSTALL* NEWS README*
}

