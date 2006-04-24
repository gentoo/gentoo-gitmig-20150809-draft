# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/rsvg-sharp/rsvg-sharp-1.0.10.ebuild,v 1.5 2006/04/24 01:30:29 metalgod Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/gtk-sharp-${PV}*
		=dev-dotnet/art-sharp-${PV}*
		>=gnome-base/librsvg-2.0.1"

GTK_SHARP_COMPONENT_BUILD_DEPS="art"
