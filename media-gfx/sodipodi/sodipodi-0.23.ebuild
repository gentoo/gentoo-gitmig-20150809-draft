# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Vector illustrating application for GNOME"
SRC_URI="http://prdownloads.sourceforge.net/sodipodi/${A}"
HOMEPAGE="http://sodipodi.sourceforge.net/"

DEPEND=">=gnome-base/gnome-print-0.21 nls? ( sys-devel/gettext )
	>=gnome-base/gal-0.4
	bonobo? ( >=gnome-base/bonobo-0.37 )"

src_compile() {

    local myconf
    if [ "`use bonobo`" ]
    then
      myconf="--with-bonobo"
    else
      myconf="--without-bonobo"
    fi
    if [ -z "`use nls`" ] ; then
      myconf="$myconf --disable-nls"
    fi
    try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--sysconfdir=/etc/opt/gnome \
	--enable-gnome --enable-gnome-print ${myconf}
    try make

}

src_install () {

    try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install
    dodoc AUTHORS COPYING ChangeLog README NEWS TODO

}





