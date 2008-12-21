# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtkhtml-sharp/gtkhtml-sharp-2.8.2.ebuild,v 1.9 2008/12/21 17:54:09 eva Exp $

EAPI="1"

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="amd64 ppc ~x86"
IUSE=""

RDEPEND="=dev-dotnet/gnome-sharp-${PV}*
	=dev-dotnet/art-sharp-${PV}*
	gnome-extra/gtkhtml:3.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
GTK_SHARP_COMPONENT_BUILD_DEPS="art gnome"
