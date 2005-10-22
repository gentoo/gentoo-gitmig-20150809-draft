# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-3.5_beta1.ebuild,v 1.3 2005/10/22 07:15:42 halcy0n Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~amd64 ~x86"
IUSE=""

# The setCustomAuthorText function seems to have been removed.
PATCHES="$FILESDIR/${P}-compile-fix.patch"
