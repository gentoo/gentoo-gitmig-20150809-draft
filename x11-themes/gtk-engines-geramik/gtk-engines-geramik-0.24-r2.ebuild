# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-geramik/gtk-engines-geramik-0.24-r2.ebuild,v 1.1 2003/05/02 17:00:45 foser Exp $

DESCRIPTION="GTK-2 theme engine to make GTK look like KDE"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=3952"
SLOT="2"

inherit gtk-engines eutils

KEYWORDS="~x86"

newdepend ">=media-libs/gdk-pixbuf-0.21"

#src_unpack() {
#	gnome2_src_unpack
#
#	cd ${S}
#	epatch ${FILESDIR}/${P}.patch
#}
