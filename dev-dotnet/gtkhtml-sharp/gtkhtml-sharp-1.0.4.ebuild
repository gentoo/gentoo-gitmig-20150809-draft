# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtkhtml-sharp/gtkhtml-sharp-1.0.4.ebuild,v 1.3 2004/12/04 12:33:08 dholm Exp $

inherit gtk-sharp-component eutils

SLOT="1"
KEYWORDS="~x86"
IUSE=""

# FIXME
DEPEND="${DEPEND}
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		=dev-dotnet/gnome-sharp-${PV}*
		=dev-dotnet/art-sharp-${PV}*
		=gnome-extra/libgtkhtml-3.0.10*"

GTK_SHARP_COMPONENT_BUILD_DEPS="art gnome"
