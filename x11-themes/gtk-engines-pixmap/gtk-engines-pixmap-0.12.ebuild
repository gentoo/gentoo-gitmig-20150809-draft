# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-pixmap/gtk-engines-pixmap-0.12.ebuild,v 1.6 2004/07/18 23:40:39 aliz Exp $

inherit gnuconfig

DESCRIPTION="Pixmap-based theme engine for GTK+"
SLOT="1"

inherit gtk-engines

src_unpack() {
	gtk-engines_src_unpack

	gnuconfig_update
}
