# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-session/gnome-session-2.0.5.ebuild,v 1.1 2002/08/08 08:27:38 stroke Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="the Gnome2 session manager"
SRC_URI="mirror://gnome/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="GPL-2 LGPL-2.1 FDL-1.1"

RDEPEND=">=dev-libs/glib-2.0.6-r1
	>=x11-libs/gtk+-2.0.6-r1
	>=gnome-base/libgnomeui-2.0.0
	>=gnome-base/libgnomecanvas-2.0.1
	>=sys-devel/gettext-0.10.40
	>=sys-apps/tcp-wrappers-7.6
	>=gnome-base/gconf-1.2.0"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.17
	!gnome-base/gnome-core"
# gnome-base/gnome-core overwrite /usr/bin/gnome-session

DOC="AUTHORS COPY* README HACKING INSTALL NEWS TODO ChangeLog"

src_install() {
	gnome2_src_install
	
	dodir /etc/X11/Sessions
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/Gnome
}




