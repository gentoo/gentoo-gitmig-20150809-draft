# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-geramik/gtk-engines-geramik-0.08-r1.ebuild,v 1.1 2002/11/28 07:54:37 leonardop Exp $

DESCRIPTION="GTK-1 theme engine to make GTK look like KDE"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=3952"
SLOT="1"

inherit gtk-engines

newdepend '>=media-libs/imlib-1.8'
