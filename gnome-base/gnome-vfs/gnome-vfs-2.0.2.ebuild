# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-2.0.2.ebuild,v 1.3 2002/09/05 21:34:48 spider Exp $

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Gnome Virtual Filesystem"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"
SLOT="2"
KEYWORDS="x86 ppc sparc sparc64"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND="=dev-libs/glib-2.0*
	>=gnome-base/gconf-1.2.1
	>=gnome-base/ORBit2-2.4.1
	>=gnome-base/gnome-mime-data-2.0.0
	>=gnome-base/libbonobo-2.0.0
	>=gnome-base/bonobo-activation-1.0.2
	>=sys-devel/gettext-0.10.40
	>=dev-libs/openssl-0.9.5
	>=sys-apps/bzip2-1.0"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.17
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS README TODO"

src_compile() {
	gnome2_src_compile DESTDIR=${D}
}

