# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Mikael Hallendal <micke@hallendal.net>

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Project management application for GNOME"
SRC_URI="ftp://ftp.codefactory.se/pub/software/mrproject/source/${A}"
HOMEPAGE="http://mrproject.codefactory.se/"

DEPEND="nls? ( sys-devel/gettext )
        >=gnome-base/gal-0.7
	>=gnome-base/bonobo-1.0.0
	>=dev-util/xml-i18n-tools-0.8.4"

RDEPEND=">=gnome-base/gal-0.7
	>=gnome-base/bonobo-1.0.0"

src_compile() {
    local myconf
    if [ -z "`use nls`" ] ; then
      myconf="--disable-nls"
    fi
    try ./configure --host=${CHOST} --prefix=/opt/gnome \
	--sysconfdir=/etc/opt/gnome --disable-more-warnings $myconf
    try make ${MAKEOPTS}

}

src_install () {

    try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome install
    dodoc AUTHORS COPYING ChangeLog README NEWS TODO

}





