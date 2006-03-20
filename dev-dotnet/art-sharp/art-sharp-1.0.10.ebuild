# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/art-sharp/art-sharp-1.0.10.ebuild,v 1.4 2006/03/20 00:16:02 metalgod Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/gtk-sharp-${PV}*
		>=media-libs/libart_lgpl-2.3.16"
