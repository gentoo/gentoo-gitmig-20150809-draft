# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/xmps/xmps-0.2.0-r1.ebuild,v 1.4 2002/07/11 06:30:42 drobbins Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="X Movie Player System"
SRC_URI="http://xmps.sourceforge.net/sources/${A}"
HOMEPAGE="http://xmps.sourceforge.net"

DEPEND=">=media-libs/smpeg-0.4.4-r1 nls? ( sys-devel/gettext )
	>=dev-lang/nasm-0.98
        >=dev-libs/popt-1.5
        =x11-libs/gtk+-1.2*
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"

RDEPEND=">=media-libs/smpeg-0.4.4-r1
        =x11-libs/gtk+-1.2*
        >=dev-libs/popt-1.5
	gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )"

src_compile() {

    local myopts
    if [ -n "`use gnome`" ] ; then
	myopts="--enable-gnome"
    fi
    if [ -z "`use nls`" ] ; then
        myopts="$myopts --disable-nls"
    fi
    try ./configure ${myopts} --host=${CHOST} --prefix=/usr
    cp Makefile Makefile.orig
    sed -e "s:\$(bindir)/xmps-config:\$(DESTDIR)\$(bindir)/xmps-config:" \
	Makefile.orig > Makefile
    try make

}

src_install () {

    try make prefix=${D}/usr install

    dodoc AUTHORS ChangeLog COPYING NEWS README TODO

}



