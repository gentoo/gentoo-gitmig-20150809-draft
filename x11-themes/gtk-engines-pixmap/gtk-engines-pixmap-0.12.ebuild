# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-pixmap/gtk-engines-pixmap-0.12.ebuild,v 1.7 2005/06/04 20:50:54 swegener Exp $

DESCRIPTION="Pixmap-based theme engine for GTK+"
SLOT="1"

inherit gnuconfig gtk-engines

src_unpack() {
	gtk-engines_src_unpack

	gnuconfig_update
}
