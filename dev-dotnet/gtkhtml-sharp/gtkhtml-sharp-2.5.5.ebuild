# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtkhtml-sharp/gtkhtml-sharp-2.5.5.ebuild,v 1.1 2005/05/19 17:04:06 latexer Exp $

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/gnome-sharp-${PV}*
		=dev-dotnet/art-sharp-${PV}*
		|| (
			=gnome-extra/libgtkhtml-3.2*
			=gnome-extra/libgtkhtml-3.0.10*
		)"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
GTK_SHARP_COMPONENT_BUILD_DEPS="art gnome"
