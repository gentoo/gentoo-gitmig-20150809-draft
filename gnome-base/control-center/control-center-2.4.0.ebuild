# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/control-center/control-center-2.4.0.ebuild,v 1.10 2004/03/17 00:31:53 geoman Exp $

inherit gnome2 eutils

DESCRIPTION="the gnome2 Desktop configuration tool"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64 ~mips"

MAKEOPTS="${MAKEOPTS} -j1"

RDEPEND=">=x11-libs/gtk+-2.2
	>=dev-libs/atk-1.2
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2.2
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/nautilus-2.2
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/gnome-desktop-2.2
	dev-libs/libxml2
	media-sound/esound
	>=x11-wm/metacity-2.4.5
	!gnome-extra/fontilus
	!gnome-extra/themus"

DEPEND="${RDEPEND}
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING README TODO INSTALL NEWS"

G2CONF="${G2CONF} --disable-schemas-install"

src_unpack() {

	unpack ${A}

	cd ${S}
	# See http://gcc.gnu.org/cgi-bin/gnatsweb.pl problem #9700 for
	# what this is about.
	use alpha && epatch ${FILESDIR}/control-center-2.2.0.1-alpha_hack.patch
	use amd64 && epatch ${FILESDIR}/control-center-2.4.0-64bit-fixes.patch

	# temporary fix for icon installation adapted by <link@sub_pop.net> (#16928)
	epatch ${FILESDIR}/${PN}-2.2-icons_install.patch

}
