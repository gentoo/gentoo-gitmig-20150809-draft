# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gnome-cups-manager/gnome-cups-manager-0.17.ebuild,v 1.16 2004/04/27 22:03:34 agriffis Exp $

inherit gnome2 eutils

DESCRIPTION="GNOME CUPS Printer Management Interface"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa ia64 amd64 ~mips"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.1.5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.20"

src_unpack() {

	unpack ${A}

	cd ${S}
	# Fix gtk+-2.4 deprecation issues (#45259)
	epatch ${FILESDIR}/${P}-fix_gtk24_deprecation.patch

}
