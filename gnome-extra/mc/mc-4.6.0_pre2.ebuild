# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/mc/mc-4.6.0_pre2.ebuild,v 1.1 2002/10/23 09:34:11 bcowan Exp $

IUSE="gpm nls samba ncurses X slang"

MY_T="${PN}-4.6.0-pre1"
S=${WORKDIR}/${MY_T}
DESCRIPTION="GNU Midnight Commander"

HOMEPAGE="http://www.ibiblio.org/mc/"
SRC_URI="http://www.ibiblio.org/pub/Linux/utils/file/managers/${PN}/${MY_T}.tar.gz
	 mirror://gentoo/${MY_T}-2002-10-22-04.diff.gz"


DEPEND="virtual/glibc
	>=sys-apps/e2fsprogs-1.19
	ncurses? ( >=sys-libs/ncurses-5.2-r5 )
	=dev-libs/glib-1.2*
	>=sys-libs/pam-0.72 
	gpm? ( >=sys-libs/gpm-1.19.3 )
	slang? ( >=sys-libs/slang-1.4.2 )
	nls? ( sys-devel/gettext )
	samba? ( >=net-fs/samba-2.2.3a-r1 )
	X? ( virtual/x11 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	patch -p1 < ${WORKDIR}/${MY_T}-2002-10-22-04.diff
}	

src_compile() {                           
	local myconf=""
	
	if ! use slang && ! use ncurses
	then  
	  myconf="${myconf} --with-included-slang"
	fi
	if use ncurses && ! use slang
	then 
	  myconf="${myconf} --with-ncurses
			    --without-slang"
	fi
	use slang && myconf="${myconf} --with-slang"
	
	use gpm && myconf="${myconf} --with-gpm-mouse=/usr"
	use gpm || myconf="${myconf} --without-gpm-mouse"

	use nls || myconf="${myconf} --disable-nls"

	use X && myconf="${myconf} --with-tm-x-support
				    --with-x"
	use X || myconf="${myconf} --without-tm-x-support
				    --without-x"
	
	use samba && myconf="${myconf} --with-samba
					--with-configdir=/etc/samba
					--with-codepagedir=/var/lib/samba/codepages"
	use samba || myconf="${myconf} --without-samba"
	
	cd ${S}

	LDFLAGS="-lcrypt -lncurses -lpam" ./configure --host=${CHOST} \
						--prefix=/usr \
						--mandir=/usr/share/man \
						--sysconfdir=/etc \
						--localstatedir=/var/lib \
						--with-vfs \
						--with-netrc \
						--with-ext2undel \
						--with-edit \
						$myconf || die

	emake || die  
}

src_install() {                               
	make prefix=${D}/usr \
	     mandir=${D}/usr/share/man \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/lib \
	     install || die

	dodoc ABOUT-NLS COPYING* FAQ INSTALL* NEWS README*
}

