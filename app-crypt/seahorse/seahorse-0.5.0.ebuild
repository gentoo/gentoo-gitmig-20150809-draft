# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-crypt/seahorse/seahorse-0.5.0.ebuild,v 1.3 2001/06/04 21:57:52 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome front end to gnupg"
SRC_URI="http://download.sourceforge.net/seahorse/${A}"
HOMEPGAE="http://seahorse.sourceforge.net/"

DEPEND="virtual/glibc virtual/x11
	>=app-crypt/gnupg-1.0.4
	>=gnome-base/gnome-libs-1.2"

src_compile() {                           
  try ./configure --host=${CHOST} --prefix=/opt/gnome
  try make
}

src_install() {
  try make prefix=${D}/opt/gnome install
  dodoc AUTHORS COPYING ChangeLog NEWS README TODO

}




