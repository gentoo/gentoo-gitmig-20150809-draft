# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-system-monitor/gnome-system-monitor-2.10.1.ebuild,v 1.9 2005/08/08 14:53:28 corsair Exp $

inherit gnome2 eutils

DESCRIPTION="The Gnome System Monitor"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=gnome-base/libgnome-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gconf-2
	>=x11-libs/libwnck-2.5
	>=gnome-base/libgtop-2.9.5
	>=x11-libs/gtk+-2.5
	>=gnome-base/gnome-vfs-2.6"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=app-text/scrollkeeper-0.3.11
	>=dev-util/intltool-0.29
	${RDEPEND}"

DOCS="AUTHORS ChangeLog HACKING README NEWS TODO"
USE_DESTDIR="1"

src_unpack() {

	unpack ${A}

	cd ${S}
	# fix warnings, it upsets ppl (#84831)
	epatch ${FILESDIR}/${P}-icon_warning.patch

}
