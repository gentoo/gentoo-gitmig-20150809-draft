# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/art-sharp/art-sharp-1.0.6.ebuild,v 1.3 2005/03/21 19:53:42 dholm Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="x86 ppc -amd64"
IUSE=""

DEPEND="${DEPEND}
		>=dev-dotnet/gtk-sharp-${PV}
		>=media-libs/libart_lgpl-2.3.16"
