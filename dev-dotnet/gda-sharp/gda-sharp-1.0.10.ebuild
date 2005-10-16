# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gda-sharp/gda-sharp-1.0.10.ebuild,v 1.3 2005/10/16 00:23:16 josejx Exp $

inherit gtk-sharp-component

SLOT="1"
KEYWORDS="~amd64 ppc x86"
IUSE=""

DEPEND="${DEPEND}
		=dev-dotnet/gtk-sharp-${PV}*
		>=gnome-extra/libgda-1.0.0"
