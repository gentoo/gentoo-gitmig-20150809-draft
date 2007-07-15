# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/vte-sharp/vte-sharp-1.0.10.ebuild,v 1.7 2007/07/15 02:54:24 mr_bones_ Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/gtk-sharp-${PV}*
		>=x11-libs/vte-0.11.10"

GTK_SHARP_COMPONENT_BUILD_DEPS="gnome art"
