# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-office/siag/siag-3.4.7.ebuild,v 1.5 2002/08/01 11:58:59 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A free Office package for Linux"
SRC_URI="ftp://siag.nu/pub/siag/${P}.tar.gz"
HOMEPAGE="http://siag.nu/"

DEPEND="virtual/x11
	>=dev-libs/gmp-3.1.1
	>=media-libs/t1lib-1.0.1
	mysql? ( dev-db/mysql )
	guile? ( dev-util/guile )"

RDEPEND="virtual/x11
	>=media-libs/t1lib-1.0.1"

src_compile() {

    local myconf
    if [ "`use mysql`" ]
    then
      myconf="--with-mysql"
    else
      myconf="--without-mysql"
    fi
    if [ "`use guile`" ]
    then
      myconf="$myconf --with-guile"
    else
      myconf="$myconf --without-guile"
    fi
# siag only supports python1.5
#    if [ "`use python`" ]
#    then
#      myconf="$myconf --with-python"
#    else
#      myconf="$myconf --without-python"
#    fi
    try ./configure --prefix=/opt/siag --mandir=/opt/siag/share/man --host=${CHOST} \
	--with-gmp --with-t1lib $myconf
    try make

}

src_install () {

    try make DESTDIR=${D} install
    insinto /etc/env.d
    doins ${FILESDIR}/10siag
}

