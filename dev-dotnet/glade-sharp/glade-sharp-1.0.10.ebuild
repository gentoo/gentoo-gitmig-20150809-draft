# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/glade-sharp/glade-sharp-1.0.10.ebuild,v 1.6 2008/11/27 18:39:22 ssuominen Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="=dev-dotnet/gtk-sharp-${PV}*
	>=gnome-base/libglade-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
