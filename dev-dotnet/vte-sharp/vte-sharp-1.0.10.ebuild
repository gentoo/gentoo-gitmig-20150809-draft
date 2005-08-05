# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/vte-sharp/vte-sharp-1.0.10.ebuild,v 1.3 2005/08/05 02:27:04 latexer Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="~ppc x86"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/gtk-sharp-${PV}*
		>=x11-libs/vte-0.11.10"

GTK_SHARP_COMPONENT_BUILD_DEPS="gnome art"

