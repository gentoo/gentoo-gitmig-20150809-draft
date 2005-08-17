# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gnomevfs-sharp/gnomevfs-sharp-2.3.90.ebuild,v 1.1 2005/08/17 00:39:50 latexer Exp $

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="${DEPEND}
		>=gnome-base/gnome-vfs-2.6"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
