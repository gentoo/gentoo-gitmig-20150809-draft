# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-geramik/gtk-engines-geramik-0.17-r2.ebuild,v 1.2 2003/02/13 17:38:59 vapier Exp $

DESCRIPTION="GTK-2 theme engine to make GTK look like KDE"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=3952"
SLOT="2"

inherit gtk-engines

KEYWORDS="~x86"

newdepend media-libs/gdk-pixbuf
