# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/vte-sharp/vte-sharp-1.0.4.ebuild,v 1.2 2004/12/30 23:30:06 swegener Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="~x86"
IUSE=""

DEPEND="${DEPEND}
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		>=x11-libs/vte-0.11.10"
