# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/dia/dia-0.86-r1.ebuild,v 1.4 2000/11/25 17:05:13 achim Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Diagram Creation Program"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/gnome-office/dia.shtml"

DEPEND=">=gnome-base/gnome-print-0.24
	>=app-arch/rpm-3.0.5"


src_compile() {

    cd ${S}
    local myconf
#    if [ "`use bonobo`" ]
#    then
#      myconf="--enable-bonobo"
#    fi
    try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--enable-gnome --enable-gnome-print ${myconf}
    # bonobo support does not work yet
    try make

}

src_install () {

    cd ${S}
    try make prefix=${D}/opt/gnome install
    dodoc AUTHORS COPYING ChangeLog README NEWS TODO KNOWN_BUGS
}





