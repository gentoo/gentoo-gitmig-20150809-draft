# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gnome-cups-manager/gnome-cups-manager-0.18.ebuild,v 1.3 2004/07/15 03:54:04 agriffis Exp $

inherit gnome2 eutils

DESCRIPTION="GNOME CUPS Printer Management Interface"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~ia64 amd64 ~mips"
IUSE=""

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
	# gcc 3.4 fix
	epatch ${FILESDIR}/${P}-paren.patch

}
