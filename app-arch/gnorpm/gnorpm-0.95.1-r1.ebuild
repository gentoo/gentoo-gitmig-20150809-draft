# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="A Gnome RPM Frontend"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )
        >=gnome-base/gnome-libs-1.2.4 >=sys-libs/db-3.2.3h
	>=gnome-base/libghttp-1.0.7
	>=app-arch/rpm-3.0.5"

DEPEND="virtual/glibc
        >=gnome-base/gnome-libs-1.2.4 >=sys-libs/db-3.2.3h
	>=gnome-base/libghttp-1.0.7
	>=app-arch/rpm-3.0.5"

src_compile() {
  try ./configure --host=${CHOST} --prefix=/opt/gnome --disable-rpmfind
  try make
}

src_install() {
  try make prefix=${D}/opt/gnome install

  dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}




