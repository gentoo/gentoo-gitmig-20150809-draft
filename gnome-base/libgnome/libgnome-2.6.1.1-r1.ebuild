# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgnome/libgnome-2.6.1.1-r1.ebuild,v 1.3 2004/07/31 03:47:41 spider Exp $

inherit gnome2 eutils

DESCRIPTION="Essential Gnome Libraries"
HOMEPAGE="http://www.gnome.org/"

IUSE="doc"
SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa ~amd64 ~ia64 ~mips ppc64"
LICENSE="GPL-2 LGPL-2"

RDEPEND=">=dev-libs/glib-2.0.3
	>=gnome-base/gconf-2
	>=gnome-base/libbonobo-2
	>=gnome-base/gnome-vfs-2.5.3
	>=media-sound/esound-0.2.26
	>=media-libs/audiofile-0.2.3
	>=dev-libs/popt-1.5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.6 )"

G2CONF="${G2CONF} --disable-schemas-install "

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-fix_sound.patch

}
