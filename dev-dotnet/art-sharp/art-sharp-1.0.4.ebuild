# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/art-sharp/art-sharp-1.0.4.ebuild,v 1.2 2004/12/04 12:17:00 dholm Exp $

inherit gtk-sharp-component eutils

SLOT="1"
KEYWORDS="~x86 ~ppc"
IUSE=""

DEPEND="${DEPEND}
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		>=media-libs/libart_lgpl-2.3.16"
