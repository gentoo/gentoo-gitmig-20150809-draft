# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gnome-sharp/gnome-sharp-1.9.2.ebuild,v 1.1 2005/04/02 01:14:40 latexer Exp $

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="~x86 ~ppc"
IUSE=""

# FIXME
DEPEND="${DEPEND}
		>=gnome-base/libgnomecanvas-2.0
		>=gnome-base/libgnomeui-2.0
		>=gnome-base/libgnomeprintui-2.0
		>=gnome-base/gnome-panel-2.6
		>=x11-libs/gtk+-2.0
		=art-sharp-${PV}*"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
GTK_SHARP_COMPONENT_BUILD_DEPS="art"
