# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/mc/mc-4.5.54-r1.ebuild,v 1.1 2001/06/20 10:09:21 hallski Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Midnight Commander"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/mc/"

DEPEND="virtual/glibc
	>=sys-libs/gpm-1.19.3
	pam? ( >=sys-libs/pam-0.72 )
	slang? ( >=sys-libs/slang-1.4.2 )
	>=sys-apps/e2fsprogs-1.19
	>=dev-libs/glib-1.2.0
	gnome? ( >=gnome-base/gnome-libs-1.2.4 )"


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
	myconf="$myconf --with-gnome --prefix=/opt/gnome"
  else
	myconf="$myconf --without-gnome --prefix=/usr"
  fi
  LDFLAGS="-lcrypt -lncurses" try ./configure --host=${CHOST} \
		--with-samba --with-vfs --with-netrc $myconf
  try make  # Doesn't work with -j 4 (hallski)
}

src_install() {                               

  if [ "`use gnome`" ] ; then
      try make prefix=${D}/opt/gnome install
  else
      try make prefix=${D}/usr install
  fi

  dodoc ABOUT-NLS COPYING* FAQ INSTALL* NEWS
  dodoc README*
}






