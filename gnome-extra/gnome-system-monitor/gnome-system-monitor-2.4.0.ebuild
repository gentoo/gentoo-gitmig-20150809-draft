# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-system-monitor/gnome-system-monitor-2.4.0.ebuild,v 1.15 2005/01/08 23:28:19 slarti Exp $

inherit gnome2 eutils

DESCRIPTION="Procman - The Gnome System Monitor"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc alpha sparc hppa amd64 ia64 mips"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libgnome-2
	>=gnome-base/gconf-2
	=gnome-base/libgtop-2.0*
	>=x11-libs/libwnck-0.12"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.22
	${RDEPEND}"

DOCS="AUTHORS ChangeLog COPYING HACKING README INSTALL NEWS TODO"

src_unpack() {

	unpack ${A}

	cd ${S}
	# fix issues with gtk+-2.4
	epatch ${FILESDIR}/${P}-fix_gtk+-2.4_build.patch

}
