# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/art-sharp/art-sharp-1.0.8.ebuild,v 1.5 2005/05/16 20:13:46 slarti Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/gtk-sharp-${PV}*
		>=media-libs/libart_lgpl-2.3.16"
