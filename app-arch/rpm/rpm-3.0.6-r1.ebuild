# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-3.0.6-r1.ebuild,v 1.3 2001/04/30 10:59:02 achim Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Red Hat Package Management Utils"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-3.0.x/${A}"
HOMEPAGE="http://www.rpm.org/"

DEPEND="nls? ( sys-devel/gettext )
    sys-libs/db
	>=sys-libs/zlib-1.1.3
	>=sys-apps/bzip2-1.0.1"

REPEND=">=sys-libs/zlib-1.1.3
	sys-libs/db
    sys-devel/perl"

src_unpack() {

  unpack ${A}
  cd ${S}
  patch -p0 < ${FILESDIR}/${P}-popt-popt.c-gentoo.diff
  # Suppress pointer warnings
  cp configure configure.orig
  sed -e "s:-Wpointer-arith::" configure.orig > configure

}

src_compile() {

    local myconf
    if [ -z "`use nls`" ]
    then
      myconf="--disable-nls"
    fi
    try ./configure --prefix=/usr --mandir=/usr/share/man ${myconf}
    try make
}

src_install() {

    try make DESTDIR=${D} install
    mv ${D}/bin/rpm ${D}/usr/bin
    rm -rf ${D}/bin

    dodoc CHANGES COPYING CREDITS GROUPS README* RPM* TODO
}

pkg_postinst() {

  ${ROOT}/usr/bin/rpm --initdb --root=${ROOT}

}



