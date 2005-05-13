# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gda-sharp/gda-sharp-1.9.3.1.ebuild,v 1.1 2005/05/13 01:09:00 latexer Exp $

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="${DEPEND}
		>=gnome-extra/libgda-1.0.0"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
