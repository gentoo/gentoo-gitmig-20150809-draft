# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-crux/gtk-engines-crux-1.9.5.ebuild,v 1.2 2003/02/13 17:38:24 vapier Exp $

DESCRIPTION="Crux is a GTK2 theme engine that will replace the Eazel theme"
SLOT="2"

inherit gtk-engines

newdepend '>=gnome-base/libgnomeui-2.0.1' '>=gnome-base/libglade-2.0.0'
DEPEND="${DEPEND} sys-devel/libtool"
