# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@bigfoot.com>
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.44.ebuild,v 1.1 2001/09/21 00:00:49 lordjoe Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="Gtk AOL Instant Messenger client"
SRC_URI="http://prdownloads.sourceforge.net/gaim/${A}"
HOMEPAGE="http://gaim.sourceforge.net"

DEPEND=">=x11-libs/gtk+-1.2.3
	nls? ( sys-devel/gettext )
	gnome? ( >=gnome-base/gnome-libs-1.2.13 )
	perl? ( >=sys-devel/perl-5.6.1 )
	nas? ( >=media-sound/nas-1.4.1-r1 )
	esd? ( >=media-sound/esound-0.2.22-r2 )
	arts? ( >=kde-base/kdelibs-2.1.1 )"
	
src_compile() {
    
    local myopts
    if [ "`use gnome`" ]
    then
    	myopts="--with-gnome=${GNOME_PATH} --enable-panel --prefix=/opt/gnome"
    else
    	myopts="--disable-gnome --disable-pixbuf --prefix=/usr/X11R6"
    fi
    if [ -z "`use esd`" ] ; then
    	myopts="$myopts --disable-esd"
    fi
    if [ -z "`use nas`" ] ; then
    	myopts="$myopts --disable-nas"
    fi
    if [ -z "`use perl`" ] ; then
    	myopts="$myopts --disable-perl"
    fi
    if [ -z "`use arts`" ] ; then
        myopts="$myopts --disable-arts"
    fi
    if [ -z "`use nls`" ] ; then
        myopts="$myopts --disable-nls"
    fi
    try ./configure --host=${CHOST} ${myopts}
    try emake

}

src_install () {

    try make DESTDIR=${D} install
    dodoc ChangeLog README README.plugins
}

