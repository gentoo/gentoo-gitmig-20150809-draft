# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/mc/mc-4.5.55.ebuild,v 1.3 2001/10/06 23:45:03 hallski Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Midnight Commander"
SRC_URI="http://www.gnome.org/projects/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/projects/mc/"

DEPEND="virtual/glibc
	>=sys-libs/gpm-1.19.3
	pam? ( >=sys-libs/pam-0.72 )
	slang? ( >=sys-libs/slang-1.4.2 )
	>=sys-apps/e2fsprogs-1.19
	>=dev-libs/glib-1.2.0
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"


src_unpack() {
	unpack ${A}

	cd ${S}/vfs
	cp smbfs.c smbfs.c.orig
	sed -e "s:/etc/smb\.conf:/etc/smb/smb\.conf:" smbfs.c.orig > smbfs.c
}

src_compile() {                           
	local myconf

	if [ "`use pam`" ] ; then
		myconf="--with-pam"
	else
		myconf="--without-pam"
	fi

	if [ "`use slang`" ] ; then
		myconf="$myconf --with-slang"
	else
		myconf="$myconf --with-included-slang"
	fi

	if [ "`use gnome`" ] ; then
		myconf="$myconf --with-gnome"
	else
		myconf="$myconf --without-gnome"
  	fi

	LDFLAGS="-lcrypt -lncurses" ./configure --host=${CHOST} 	\
						--prefix=/usr		\
						--with-samba 		\
						--with-vfs 		\
						--with-netrc $myconf || die

	make || die  # Doesn't work with -j 4 (hallski)
}

src_install() {                               
	make prefix=${D}/usr sysconfdir=${D}/etc install || die

	dodoc ABOUT-NLS COPYING* FAQ INSTALL* NEWS README*
}
