# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-cd-burner/nautilus-cd-burner-2.8.2.ebuild,v 1.5 2004/11/12 10:28:27 obz Exp $

inherit gnome2 eutils

DESCRIPTION="CD and DVD writer plugin for Nautilus"
HOMEPAGE="http://www.gnome.org/"
LICENSE="GPL-2 LGPL-2"

IUSE="dvdr hal"
SLOT="0"
KEYWORDS="x86 ppc sparc ~hppa ~amd64 ~alpha ~ia64 ~mips"

RDEPEND=">=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4
	>=gnome-base/gnome-vfs-2.2
	>=gnome-base/eel-2
	>=gnome-base/nautilus-2.6
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	virtual/cdrtools
	hal? ( >=sys-apps/hal-0.2.92 )
	dvdr? ( app-cdr/dvd+rw-tools )"

DEPEND=">=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.9.0
	${RDEPEND}"

G2CONF="${G2CONF} $(use_enable hal)"
DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README TODO"

src_unpack() {

	unpack ${A}

	cd ${S}
	# fix crash when no cddrive is attached
	epatch ${FILESDIR}/${P}-bacon_nodrive.patch

}
