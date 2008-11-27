# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtkhtml-sharp/gtkhtml-sharp-2.16.0.ebuild,v 1.12 2008/11/27 19:01:06 ssuominen Exp $

GTK_SHARP_TARBALL_PREFIX="gnome-sharp"
GTK_SHARP_REQUIRED_VERSION="2.10"

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=dev-dotnet/gnome-sharp-${PV}*
	=dev-dotnet/art-sharp-${PV}*
	|| (
		=gnome-extra/gtkhtml-3.12*
		=gnome-extra/gtkhtml-3.6*
		=gnome-extra/gtkhtml-3.2*
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
GTK_SHARP_COMPONENT_BUILD_DEPS="art gnome"
