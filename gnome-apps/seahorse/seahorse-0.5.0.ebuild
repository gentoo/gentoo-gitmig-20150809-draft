# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-apps/seahorse/seahorse-0.5.0.ebuild,v 1.4 2001/06/07 05:22:23 blutgens Exp $

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




