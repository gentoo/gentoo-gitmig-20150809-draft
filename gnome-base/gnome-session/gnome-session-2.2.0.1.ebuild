# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-session/gnome-session-2.2.0.1.ebuild,v 1.1 2003/01/31 01:40:23 foser Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="the Gnome2 session manager"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2 LGPL-2 FDL-1.1"

RDEPEND=">=x11-libs/gtk+-2.1
	>=media-sound/esound-0.2.26
	>=gnome-base/libgnomeui-2
	>=sys-devel/gettext-0.10.40
	>=sys-apps/tcp-wrappers-7.6"

DEPEND="${RDEPEND}
	>=gnome-base/gconf-1.2.1
	>=dev-util/pkgconfig-0.12.0
	>=dev-util/intltool-0.22
	!gnome-base/gnome-core"
# gnome-base/gnome-core overwrite /usr/bin/gnome-session

DOC="AUTHORS COPYING* README HACKING INSTALL NEWS TODO ChangeLog"

src_install() {
	gnome2_src_install
	
	dodir /etc/X11/Sessions
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/Gnome
}
