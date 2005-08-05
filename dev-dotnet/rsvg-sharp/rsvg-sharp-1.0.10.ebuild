# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/rsvg-sharp/rsvg-sharp-1.0.10.ebuild,v 1.2 2005/08/05 02:26:07 latexer Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/gtk-sharp-${PV}*
		=dev-dotnet/art-sharp-${PV}*
		>=gnome-base/librsvg-2.0.1"

GTK_SHARP_COMPONENT_BUILD_DEPS="art"
