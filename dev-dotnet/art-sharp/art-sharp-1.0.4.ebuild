# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/art-sharp/art-sharp-1.0.4.ebuild,v 1.8 2005/02/14 18:13:39 kugelfang Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="~x86 ~ppc -amd64"
IUSE=""

DEPEND="${DEPEND}
		>=dev-dotnet/gtk-sharp-1.0.4-r1
		>=media-libs/libart_lgpl-2.3.16"
