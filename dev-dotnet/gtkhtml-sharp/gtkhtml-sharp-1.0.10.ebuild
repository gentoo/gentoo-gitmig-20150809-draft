# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtkhtml-sharp/gtkhtml-sharp-1.0.10.ebuild,v 1.5 2006/03/20 00:24:26 metalgod Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="amd64 ppc x86"
IUSE=""

# FIXME
DEPEND="${DEPEND}
		=dev-dotnet/gtk-sharp-${PV}*
		=dev-dotnet/gnome-sharp-${PV}*
		=dev-dotnet/art-sharp-${PV}*
		|| (
			=gnome-extra/gtkhtml-3.2*
			=gnome-extra/gtkhtml-3.0.10*
		)"

GTK_SHARP_COMPONENT_BUILD_DEPS="art gnome"
