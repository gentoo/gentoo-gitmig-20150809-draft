# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtkhtml-sharp/gtkhtml-sharp-1.0.10.ebuild,v 1.8 2008/11/27 19:01:06 ssuominen Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=dev-dotnet/gtk-sharp-${PV}*
	=dev-dotnet/gnome-sharp-${PV}*
	=dev-dotnet/art-sharp-${PV}*
	=gnome-extra/gtkhtml-3.2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

GTK_SHARP_COMPONENT_BUILD_DEPS="art gnome"
