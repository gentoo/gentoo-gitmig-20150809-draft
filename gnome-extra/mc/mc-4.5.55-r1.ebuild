# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/mc/mc-4.5.55-r1.ebuild,v 1.1 2002/03/10 09:41:05 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME Midnight Commander"
SRC_URI="http://www.gnome.org/projects/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/projects/mc/"

DEPEND="virtual/glibc
	gpm? ( >=sys-libs/gpm-1.19.3 )
	pam? ( >=sys-libs/pam-0.72 )
	slang? ( >=sys-libs/slang-1.4.2 )
	>=sys-apps/e2fsprogs-1.19
	>=dev-libs/glib-1.2.0
	nls? ( sys-devel/gettext )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"


src_unpack() {
	unpack ${A}

	cd ${S}/vfs
	cp smbfs.c smbfs.c.orig
	sed -e "s:/etc/smb\.conf:/etc/smb/smb\.conf:" smbfs.c.orig > smbfs.c
}

src_compile() {                           
	local myconf

	use pam && myconf="${myconf} --with-pam"
	use pam || myconf="${myconf} --without-pam"

	use slang && myconf="${myconf} --with-slang"
	use slang || myconf="${myconf} --with-included-slang"

	use gnome && myconf="${myconf} --with-gnome"
	use gnome || myconf="${myconf} --without-gnome"

	use nls || myconf="${myconf} --disable-nls"

	LDFLAGS="-lcrypt -lncurses" ./configure --host=${CHOST} 	 \
						--prefix=/usr		 \
						--sysconfdir=/etc	 \
						--localstatedir=/var/lib \
						--with-samba 		 \
						--with-vfs 		 \
						--with-netrc 		 \
						$myconf || die

	make || die  # Doesn't work with -j 4 (hallski)
}

src_install() {                               
	make prefix=${D}/usr						 \
	     sysconfdir=${D}/etc					 \
	     localstatedir=${D}/var/lib					\
	     install || die

	dodoc ABOUT-NLS COPYING* FAQ INSTALL* NEWS README*
}
