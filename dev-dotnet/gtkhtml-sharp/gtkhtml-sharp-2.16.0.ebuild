# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtkhtml-sharp/gtkhtml-sharp-2.16.0.ebuild,v 1.4 2007/02/11 04:17:14 pylon Exp $

GTK_SHARP_TARBALL_PREFIX="gnome-sharp"
GTK_SHARP_REQUIRED_VERSION="2.10"

inherit gtk-sharp-component

SLOT="2"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/gnome-sharp-${PV}*
		=dev-dotnet/art-sharp-${PV}*
		|| (
			=gnome-extra/gtkhtml-3.12*
			=gnome-extra/gtkhtml-3.10*
			=gnome-extra/gtkhtml-3.8*
			=gnome-extra/gtkhtml-3.6*
			=gnome-extra/gtkhtml-3.2*
			=gnome-extra/gtkhtml-3.0.10*
		)"

GTK_SHARP_COMPONENT_SLOT="2"
GTK_SHARP_COMPONENT_SLOT_DEC="-2.0"
GTK_SHARP_COMPONENT_BUILD_DEPS="art gnome"
