# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/mc/mc-4.5.55-r6.ebuild,v 1.2 2002/08/25 22:10:04 gerk Exp $

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
	ncurses? ( >=sys-libs/ncurses-5.2 )
	slang? ( >=sys-libs/slang-1.4.2 )
	nls? ( sys-devel/gettext )
	samba? ( >=net-fs/samba-2.2.3a-r1 )
	X? ( virtual/x11 )"
#currently broken
#	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

src_compile() {                           
	local myconf=""

	use pam && myconf="${myconf} --with-pam"
	use pam || myconf="${myconf} --without-pam"

	use ncurses && myconf="${myconf} --with-ncurses" || ( \
	use slang && myconf="${myconf} --with-slang"
	use slang || myconf="${myconf} --with-included-slang"
	)

#currently broken
#	use gnome && myconf="${myconf} --with-gnome"
#	use gnome || myconf="${myconf} --without-gnome"
	myconf="${myconf} --without-gnome"

	use gpm && myconf="${myconf} --with-gpm-mouse=/usr"
	use gpm || myconf="${myconf} --without-gpm-mouse"

	use nls || myconf="${myconf} --disable-nls"

	use X && myconf="${myconf} --with-tm-x-support"
	use X || myconf="${myconf} --without-tm-x-support"

	use samba && myconf="${myconf} --with-samba"
	use samba && ( \
		cd ${S}/vfs
		cp smbfs.c smbfs.c.orig
		sed -e "s:/etc/smb\.conf:/etc/samba/smb\.conf:" smbfs.c.orig > smbfs.c
		cd samba
		cp Makefile.in Makefile.in.orig
		sed -e 's:$(LIBDIR)\(/codepages\):/var/lib/samba\1:' \
			Makefile.in.orig > Makefile.in
	)

	cd ${S}
#	export WANT_AUTOMAKE_1_5=1
	libtoolize --force --copy
	aclocal -I ${S}/macros
#	autoconf
	automake --add-missing

	./configure --host=${CHOST} 	 \
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

