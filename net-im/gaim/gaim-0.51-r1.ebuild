# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Joe Bormolini <lordjoe@bigfoot.com>, Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.51-r1.ebuild,v 1.1 2002/01/27 06:21:16 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gtk AOL Instant Messenger client"
SRC_URI="http://prdownloads.sourceforge.net/gaim/${P}.tar.bz2"
HOMEPAGE="http://gaim.sourceforge.net"

DEPEND=">=x11-libs/gtk+-1.2.10-r4
	nls? ( sys-devel/gettext )
	gnome? ( >=gnome-base/gnome-core-1.4 )
	perl? ( >=sys-devel/perl-5.6.1 )
	nas? ( >=media-libs/nas-1.4.1-r1 )
	esd? ( >=media-sound/esound-0.2.22-r2 )
	arts? ( >=kde-base/kdelibs-2.1.1 )"
	
src_compile() {
    
    local myopts gnomeopts

    # note for clarity: || means not enabled, && means enabled
    use esd ||  myopts="--disable-esd"
    use nas ||  myopts="$myopts --disable-nas"
    use perl || myopts="$myopts --disable-perl"

    use arts || myopts="$myopts --disable-arts"
    use arts && KDEDIR=/usr/kde/2

    use nls || myopts="$myopts --disable-nls"

    gnomeopts="${myopts}"

    # if gnome support is disabled, do not build standalone with pixbuf
    use gnome || myopts="${myopts} --disable-pixbuf"

    # always build standalone gaim program
    ./configure --host=${CHOST} --disable-gnome --prefix=/usr ${myopts} || die
    emake || die


    # if gnome support is enabled, also build gaim_applet
    if [ "`use gnome`" ]
    then
	# if gnome support is enabled, then build gaim_applet
	gnomeopts="${gnomeopts} --with-gnome=${GNOME_PATH} --enable-panel"

	./configure --host=${CHOST} --prefix=/usr ${gnomeopts} || die
    	emake || die
    fi

}

src_install () {

    try make DESTDIR=${D} install

    # if gnome enabled, make sure to install standalone version also
    use gnome && dobin src/gaim

    dodoc ChangeLog README README.plugins
}

