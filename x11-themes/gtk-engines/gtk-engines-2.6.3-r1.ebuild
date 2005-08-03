# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines/gtk-engines-2.6.3-r1.ebuild,v 1.1 2005/08/03 06:38:09 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="GTK+2 standard engines and themes"
HOMEPAGE="http://www.gtk.org/"

KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
LICENSE="GPL-2 LGPL-2.1"
SLOT="2"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.6
	!<=x11-themes/gnome-themes-2.8.2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Install the clearlooks engine in the right location
	epatch ${FILESDIR}/${P}-fix_clearlooks_path.patch
}
