# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/vte-sharp/vte-sharp-1.0.4.ebuild,v 1.4 2005/02/07 19:39:06 dholm Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="${DEPEND}
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		>=x11-libs/vte-0.11.10"
