# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/glade-sharp/glade-sharp-1.0.4.ebuild,v 1.10 2005/02/19 19:05:43 dholm Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="~x86 ppc -amd64"
IUSE=""

DEPEND="${DEPEND}
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		>=gnome-base/libglade-2"
