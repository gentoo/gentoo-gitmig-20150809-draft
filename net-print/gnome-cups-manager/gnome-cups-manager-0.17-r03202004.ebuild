# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/gnome-cups-manager/gnome-cups-manager-0.17-r03202004.ebuild,v 1.1 2004/03/20 18:21:35 foser Exp $

inherit gnome2

DESCRIPTION="GNOME CUPS Printer Management Interface"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="mirror://gentoo/${PN}-03202004.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~ia64 ~amd64 ~mips"

RDEPEND=">=dev-libs/glib-2.3.1
	>=x11-libs/gtk+-2.3.1
	>=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libbonobo-2
	>=net-print/libgnomecups-0.1.5"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

S=${WORKDIR}/${PN}
