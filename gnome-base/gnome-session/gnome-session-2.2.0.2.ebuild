# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-session/gnome-session-2.2.0.2.ebuild,v 1.7 2003/05/30 02:21:38 lu_zero Exp $

inherit gnome2 eutils

S=${WORKDIR}/${P}
DESCRIPTION="the Gnome2 session manager"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
KEYWORDS="x86 ppc alpha ~sparc"
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

src_unpack() {
	unpack ${A}
	cd ${S}

	# This patch is only necessary on 64-bit platforms such as Alpha
	# but it doesn't hurt elsewhere.
	epatch ${FILESDIR}/${PN}-2.0.9-64bit.patch || die
}

src_install() {
	gnome2_src_install
	
	dodir /etc/X11/Sessions
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/Gnome
}
