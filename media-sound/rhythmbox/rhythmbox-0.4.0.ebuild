# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rhythmbox/rhythmbox-0.4.0.ebuild,v 1.1 2002/11/15 12:03:31 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="RhythmBox - an iTunes clone for GNOME"
SRC_URI="http://www.rhythmbox.org/download/${P}.tar.gz"
HOMEPAGE="http://www.rhythmbox.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=x11-libs/gtk+-2.0.0
	=gnome-base/libgnomeui-2.0*
	=gnome-base/libglade-2.0*
	=gnome-base/gnome-panel-2.0*	
	=gnome-base/gnome-vfs-2.0*
	=gnome-base/libbonobo-2.0*
	=gnome-base/bonobo-activation-1.0*
	=gnome-base/libgnomecanvas-2.0*
	>=media-libs/monkey-media-0.6.0
	>=gnome-base/gconf-1.2.1
	>=gnome-base/ORBit2-2.4.1
	>=sys-devel/gettext-0.11.1
	>=media-libs/gst-plugins-0.4.2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool"

src_install () {

	# this is a fix to disable scrollkeeper-update from running in 
	# "make install" since that breaks sandbox. 
	cd help/C
	cat Makefile | sed s/"install-data-hook: install-data-hook-omf"/"install-data-hook:"/g >Makefile.new
	mv Makefile.new Makefile
	cd ../..
	gnome2_src_install 
	
}

LIBTOOL_FIX="1"

DOC="AUTHORS COPYING ChangeLog  INSTALL INSTALL.GNU HACKING NEWS README THANKS TODO"
SCHEMA="rhythmbox.schemas"
