# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gnome-cups-manager/gnome-cups-manager-0.28.ebuild,v 1.11 2005/04/01 22:15:31 pylon Exp $

inherit gnome2 eutils

DESCRIPTION="GNOME CUPS Printer Management Interface"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~alpha sparc hppa ia64 amd64 arm ~mips"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	=net-print/libgnomecups-0.1.14
	app-admin/gnomesu"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29"

src_install() {
	gnome2_src_install
	insinto /usr/share/applications
	doins ${FILESDIR}/${PN}.desktop
}
