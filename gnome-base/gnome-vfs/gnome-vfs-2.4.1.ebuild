# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-2.4.1.ebuild,v 1.5 2004/01/29 04:47:41 agriffis Exp $

inherit gnome2 eutils

IUSE="doc ssl"

SLOT="2"

DESCRIPTION="Gnome Virtual Filesystem"
HOMEPAGE="http://www.gnome.org/"
KEYWORDS="x86 ~ppc alpha sparc hppa ~amd64 ia64"
LICENSE="GPL-2 LGPL-2.1"

RDEPEND=">=dev-libs/glib-2
	>=gnome-base/gconf-1.2
	>=gnome-base/ORBit2-2.4
	>=gnome-base/libbonobo-2
	>=dev-libs/libxml2-2.2.8
	>=gnome-base/gnome-mime-data-2

	app-admin/fam
	ssl? ( >=dev-libs/openssl-0.9.5 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS COPYING* ChangeLog HACKING INSTALL NEWS README TODO"

G2CONF="${G2CONF} $(use_enable ssl openssl) --disable-schemas-install"

src_install() {

	gnome2_src_install

	# FIXME: there are cleaner ways to do this
	echo "trash:    libvfolder-desktop" >> ${D}/etc/gnome-vfs-2.0/modules/default-modules.conf

}
