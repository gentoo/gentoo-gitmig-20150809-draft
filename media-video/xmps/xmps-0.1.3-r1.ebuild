# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/xmps/xmps-0.1.3-r1.ebuild,v 1.5 2000/11/05 12:59:09 achim Exp $

P=xmps-0.1.3
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="X Movie Player System"
SRC_URI="http://www-eleves.enst-bretagne.fr/~chavarri/xmps/sources/${A}"
HOMEPAGE="http://www-eleves.enst-bretagne.fr/~chavarri/xmps/"

DEPEND=">=media-libs/smpeg-0.4.1
	>=dev-lang/nasm-0.98
	gnome? ( >=gnome-base/gnome-libs-1.2.4 )"

RDEPEND=">=media-libs/smpeg-0.4.1
	gnome? ( >=gnome-base/gnome-libs-1.2.4 )"

src_compile() {

    cd ${S}
    local myopts
    if [ -n "`use gnome`" ]
    then
	myopts="--enable-gnome --prefix=/opt/gnome"
    else
	myopts="--disable-gnome --prefix=/usr/X11R6"
    fi
    try ./configure ${myopts} --host=${CHOST} \
	--with-catgets
    cp Makefile Makefile.orig
    sed -e "s:\$(bindir)/xmps-config:\$(DESTDIR)\$(bindir)/xmps-config:" \
	Makefile.orig > Makefile
    try make

}

src_install () {

    cd ${S}
    try make DESTDIR=${D} install
    dodoc AUTHORS ChangeLog COPYING NEWS README TODO

}



