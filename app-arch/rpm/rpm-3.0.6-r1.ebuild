# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-3.0.6-r1.ebuild,v 1.4 2001/05/28 05:24:13 achim Exp $

A="${P}.tar.gz"
S=${WORKDIR}/${P}
DESCRIPTION="Red Hat Package Management Utils"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-3.0.x/${A}"
HOMEPAGE="http://www.rpm.org/"

RDEPEND="=sys-libs/db-1.85-r1
	>=sys-libs/zlib-1.1.3
	>=sys-apps/bzip2-1.0.1"

DEPEND="$RDEPEND nls? ( sys-devel/gettext )"

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



