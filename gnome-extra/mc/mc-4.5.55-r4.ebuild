# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/mc/mc-4.5.55-r4.ebuild,v 1.5 2002/08/01 11:59:02 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Midnight Commander"
SRC_URI="http://www.gnome.org/projects/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/projects/mc/"

DEPEND="virtual/glibc
	>=sys-apps/e2fsprogs-1.19
	=dev-libs/glib-1.2*
	>=sys-devel/automake-1.5d-r1
	gpm? ( >=sys-libs/gpm-1.19.3 )
	pam? ( >=sys-libs/pam-0.72 )
	slang? ( >=sys-libs/slang-1.4.2 )
	nls? ( sys-devel/gettext )
	samba? ( >=net-fs/samba-2.2.3a-r1 )
	X? ( virtual/x11 )"
#currently broken
#	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

src_compile() {                           
	local myconf=""

	use pam && myconf="${myconf} --with-pam"
	use pam || myconf="${myconf} --without-pam"

	use slang && myconf="${myconf} --with-slang"
	use slang || myconf="${myconf} --with-included-slang"

#currently broken
#	use gnome && myconf="${myconf} --with-gnome"
#	use gnome || myconf="${myconf} --without-gnome"
	myconf="${myconf} --without-gnome"

	use gpm && myconf="${myconf} --with-gpm-mouse=/usr"
	use gpm || myconf="${myconf} --without-gpm-mouse"

	use nls || myconf="${myconf} --disable-nls"

	use X && myconf="${myconf} --with-tm-x-support"
	use X || myconf="${myconf} --without-tm-x-support"

	if [ "`use samba`" ] ; then
		cd ${S}/vfs
		cp smbfs.c smbfs.c.orig
		sed -e "s:/etc/smb\.conf:/etc/smb/smb\.conf:" smbfs.c.orig > smbfs.c
		myconf="${myconf} --with-samba"
	fi

	cd ${S}
#	export WANT_AUTOMAKE_1_5=1
	libtoolize --force --copy
	aclocal -I ${S}/macros
#	autoconf
	automake --add-missing

	LDFLAGS="-lcrypt -lncurses" ./configure --host=${CHOST} 	 \
						--prefix=/usr		 \
						--mandir=/usr/share/man	 \
						--sysconfdir=/etc	 \
						--localstatedir=/var/lib \
						--with-vfs 		 \
						--with-netrc 		 \
						--with-ext2undel	\
						$myconf || die

	make || die  # Doesn't work with -j 4 (hallski)
}

src_install() {                               
	make prefix=${D}/usr						 \
	     mandir=${D}/usr/share/man					 \
	     sysconfdir=${D}/etc					 \
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc ABOUT-NLS COPYING* FAQ INSTALL* NEWS README*
}

