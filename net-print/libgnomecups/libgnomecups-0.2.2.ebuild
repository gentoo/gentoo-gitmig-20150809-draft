# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libgnomecups/libgnomecups-0.2.2.ebuild,v 1.14 2009/01/31 18:54:58 eva Exp $

inherit eutils gnome2

DESCRIPTION="GNOME cups library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="arm sh"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=net-print/cups-1.3.8"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.28"

DOCS="AUTHORS ChangeLog NEWS"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/enablenet.patch
}
