# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rhythmbox/rhythmbox-0.4.1-r1.ebuild,v 1.3 2003/03/16 14:54:34 azarah Exp $

inherit eutils gnome2

S="${WORKDIR}/${P}"
DESCRIPTION="RhythmBox - an iTunes clone for GNOME"
SRC_URI="http://www.rhythmbox.org/download/${P}.tar.gz"
HOMEPAGE="http://www.rhythmbox.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

RDEPEND=">=x11-libs/gtk+-2.0.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/libglade-2.0
	>=gnome-base/gnome-panel-2.0
	>=gnome-base/gnome-vfs-2.0
	>=gnome-base/libbonobo-2.0
	>=gnome-base/bonobo-activation-1.0
	>=gnome-base/libgnomecanvas-2.0
	>=media-libs/monkey-media-0.6.1
	>=gnome-base/gconf-1.2.1
	>=gnome-base/ORBit2-2.4.1
	>=sys-devel/gettext-0.11.1
	=media-libs/gst-plugins-0.4.2*"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	dev-util/intltool"


src_unpack() {
	
	unpack ${A}

	# Soften the message displayed at startup, and only do
	# it once.  Ugly hack I know, but somebody with more C
	# will have to fix this if need be ...
	# <azarah@gentoo.org> (27 Dec 2002).
	cd ${S}; epatch ${FILESDIR}/${PN}-0.4.1-check_gentoo-be-nicer.patch
}

src_compile() {
	# disable -Werror
	econf --enable-compile-warnings=yes 
	emake || die "compile failed"
}

src_install () {

	# this is a fix to disable scrollkeeper-update from running in 
	# "make install" since that breaks sandbox. 
	cd help/C
	cat Makefile | sed s/"install-data-hook: install-data-hook-omf"/"install-data-hook:"/g >Makefile.new
	mv Makefile.new Makefile
	cd ../..
	gnome2_src_install 
	
}

DOC="AUTHORS COPYING ChangeLog  INSTALL INSTALL.GNU HACKING NEWS README THANKS TODO"
SCHEMA="rhythmbox.schemas"

