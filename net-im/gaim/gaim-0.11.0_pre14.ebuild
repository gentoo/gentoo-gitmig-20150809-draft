# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@bigfoot.com>

P2=gaim-0.11.0pre14
S=${WORKDIR}/${P2}
DESCRIPTION="Gtk AOL Instant Messenger client"
SRC_URI="http://prdownloads.sourceforge.net/gaim/${P2}.tar.bz2"
HOMEPAGE="http://gaim.sourceforge.net"

DEPEND=">=x11-libs/gtk+-1.2.3
	gnome? ( >=gnome-base/gnome-libs-1.2.13 )
	perl? ( >=sys-devel/perl-5.6.1 )
	nas? ( >=media-sound/nas-1.4.1-r1 )
	esd? ( >=media-sound/esound-0.2.22-r2 )"
	
src_compile() {
    
    local myopts
    if [ "`use gnome`" ]
    then
    	myopts="--with-gnome=${GNOMEDIR} --enable-panel --prefix=/opt/gnome"
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
    try ./configure --host=${CHOST} ${myopts}
    try pmake

}

src_install () {

    try make DESTDIR=${D} install
    dodoc ChangeLog README README.plugins
}

