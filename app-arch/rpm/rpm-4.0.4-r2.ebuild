# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-4.0.4-r2.ebuild,v 1.6 2002/07/16 00:52:14 owen Exp $

# note to self: check for java deps

S=${WORKDIR}/${P}
DESCRIPTION="Red Hat Package Management Utils"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.0.x/${P}.tar.gz"
HOMEPAGE="http://www.rpm.org/"
LICENSE="GPL|LGPL"

RDEPEND="=sys-libs/db-3.2*
	>=sys-libs/zlib-1.1.3
	>=sys-apps/bzip2-1.0.1
	>=dev-libs/popt-1.6.3"

DEPEND="$RDEPEND nls? ( sys-devel/gettext )"
KEYWORDS="x86 ppc"

src_unpack() {

  unpack ${A}
  cd ${S}
  patch -p1 < ${FILESDIR}/${P}-system-popt.diff
  rm -rf ${S}/popt
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



