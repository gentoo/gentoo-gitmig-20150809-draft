# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomeicu/gnomeicu-0.99.ebuild,v 1.1 2003/03/11 18:42:05 spider Exp $

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
	>=net-libs/gnet-1.1.4
	>=gnome-base/gnome-panel-2.0.0
	>=app-text/scrollkeeper-0.3.5
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22"
	
RDEPEND="sys-devel/gettext"

src_unpack () {
	unpack ${A}
	cd ${S}/doc/C
	cp Makefile.in Makefile.in.old
	sed -e "s:-scrollkeeper-update.*::g" \
		Makefile.in.old > Makefile.in
	rm Makefile.in.old
	cd ${S}
}
DOCS="AUTHORS COPYING CREDITS ChangeLog README ABOUT-NLS"


