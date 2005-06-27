# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/vte-sharp/vte-sharp-1.0.10.ebuild,v 1.2 2005/06/27 00:59:46 urilith Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/gtk-sharp-${PV}*
		>=x11-libs/vte-0.11.10"

GTK_SHARP_COMPONENT_BUILD_DEPS="gnome art"

