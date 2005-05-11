# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/vte-sharp/vte-sharp-1.9.3.ebuild,v 1.2 2005/05/11 17:53:58 latexer Exp $

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="${DEPEND}
		>=dev-dotnet/gnome-sharp-${PV}
		>=x11-libs/vte-0.11.10"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
GTK_SHARP_COMPONENT_BUILD_DEPS="gnome art"
