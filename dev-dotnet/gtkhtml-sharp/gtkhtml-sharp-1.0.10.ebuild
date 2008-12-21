# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtkhtml-sharp/gtkhtml-sharp-1.0.10.ebuild,v 1.9 2008/12/21 17:54:09 eva Exp $

EAPI="1"

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=dev-dotnet/gtk-sharp-${PV}*
	=dev-dotnet/gnome-sharp-${PV}*
	=dev-dotnet/art-sharp-${PV}*
	gnome-extra/gtkhtml:3.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

GTK_SHARP_COMPONENT_BUILD_DEPS="art gnome"
