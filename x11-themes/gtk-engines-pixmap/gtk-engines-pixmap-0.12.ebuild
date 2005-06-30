# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-pixmap/gtk-engines-pixmap-0.12.ebuild,v 1.8 2005/06/30 21:04:32 leonardop Exp $

SLOT="1"
inherit gnuconfig gtk-engines

DESCRIPTION="Pixmap-based theme engine for GTK+"

src_unpack() {
	gtk-engines_src_unpack

	gnuconfig_update
}
