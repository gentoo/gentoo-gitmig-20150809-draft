# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomeicu/gnomeicu-0.99-r1.ebuild,v 1.3 2003/05/09 22:42:31 liquidx Exp $

inherit gnome2 

S=${WORKDIR}/${P}
DESCRIPTION="Gnome ICQ Client"
SRC_URI="mirror://sourceforge/gnomeicu/${P}.tar.bz2"
HOMEPAGE="http://gnomeicu.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc  ~ppc ~alpha" 

DEPEND=">=x11-libs/gtk+-2.0.5
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=sys-libs/gdbm-1.8.0
	>=gnome-base/libglade-2.0.0	
	<net-libs/gnet-2
	>=app-text/scrollkeeper-0.3.5
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22
	>=gnome-base/gconf-2.0
	sys-devel/gettext"
# the dependency on gnome-panel was wrong in configure.in

src_unpack () {
	unpack ${A}
	cd ${S}/doc/C; sed -i -e 's:-scrollkeeper-update.*:-scrollkeeper-update -p $(scrollkeeper_localstate_dir) -o $(DESTDIR)$(omf_dest_dir):' Makefile.in
}

DOCS="AUTHORS COPYING CREDITS ChangeLog README ABOUT-NLS"


