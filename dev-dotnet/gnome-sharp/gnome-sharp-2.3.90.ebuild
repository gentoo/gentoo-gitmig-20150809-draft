# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gnome-sharp/gnome-sharp-2.3.90.ebuild,v 1.1 2005/08/17 00:39:18 latexer Exp $

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

# FIXME
DEPEND="${DEPEND}
		>=gnome-base/libgnomecanvas-2.6
		>=gnome-base/libgnomeui-2.6
		>=gnome-base/libgnomeprintui-2.6
		>=gnome-base/gnome-panel-2.6
		>=x11-libs/gtk+-2.4.0
		~dev-dotnet/gnomevfs-sharp-${PV}
		~dev-dotnet/art-sharp-${PV}"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
GTK_SHARP_COMPONENT_BUILD_DEPS="art"
