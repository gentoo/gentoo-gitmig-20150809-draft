# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/mc/mc-4.5.55-r2.ebuild,v 1.1 2002/03/23 12:20:09 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Midnight Commander"
SRC_URI="http://www.gnome.org/projects/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/projects/mc/"

DEPEND="virtual/glibc
	>=sys-apps/e2fsprogs-1.19
	>=dev-libs/glib-1.2.0
	gpm? ( >=sys-libs/gpm-1.19.3 )
	pam? ( >=sys-libs/pam-0.72 )
	slang? ( >=sys-libs/slang-1.4.2 )
	nls? ( sys-devel/gettext )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
	samba? ( >=net-fs/samba-2.2.3a-r1 )"


src_compile() {                           
	local myconf

	use pam && myconf="${myconf} --with-pam" \
		|| myconf="${myconf} --without-pam"

	use slang && myconf="${myconf} --with-slang" \
		|| myconf="${myconf} --with-included-slang"

	use gnome && myconf="${myconf} --with-gnome" \
		|| myconf="${myconf} --without-gnome"

	use gpm && myconf="${myconf} --with-gpm-mouse=/usr" \
		|| myconf="${myconf} --without-gpm-mouse"

	use nls || myconf="${myconf} --disable-nls"

	if [ "`use samba`" ] ; then
		cd ${S}/vfs
		cp smbfs.c smbfs.c.orig
		sed -e "s:/etc/smb\.conf:/etc/smb/smb\.conf:" smbfs.c.orig > smbfs.c
		myconf="${myconf} --with-samba"
	fi

	libtoolize --force --copy
	aclocal

	LDFLAGS="-lcrypt -lncurses" ./configure --host=${CHOST} 	 \
						--prefix=/usr		 \
						--mandir=/usr/share/man	 \
						--sysconfdir=/etc	 \
						--localstatedir=/var/lib \
						--with-vfs 		 \
						--with-netrc 		 \
						--with-ext2undel	\
						--with-x	\
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
