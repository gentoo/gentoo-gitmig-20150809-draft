# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/mc/mc-4.5.51.ebuild,v 1.6 2000/12/03 23:05:56 drobbins Exp $

P=mc-4.5.51
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="GNOME Midnight Commander"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/mc/"${A}
HOMEPAGE="http://www.gnome.org/mc/"

DEPEND=">=sys-libs/pam-0.72
	>=sys-libs/slang-1.4.2
	>=sys-apps/e2fsprogs-1.19
	>=gnome-base/gnome-libs-1.2.4
"
RDEPEND="virtual/x11-web-browser"

src_unpack() {
  unpack ${A}
  cd ${S}/vfs
  cp smbfs.c smbfs.c.orig
  sed -e "s:/etc/smb\.conf:/etc/smb/smb\.conf:" smbfs.c.orig > smbfs.c
}

src_compile() {                           
  cd ${S}
  LDFLAGS="-lcrypt -lncurses" try ./configure --host=${CHOST} --prefix=/opt/gnome \
		--with-samba --with-ldap --with-pam --with-vfs \
		--with-netrc --with-slang
  try make
}

src_install() {                               
  cd ${S}
  try make prefix=${D}/opt/gnome install
  prepman /opt/gnome

  dodoc ABOUT-NLS COPYING* FAQ INSTALL* NEWS
  dodoc README*
}






