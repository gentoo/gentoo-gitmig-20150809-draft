# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kolourpaint/kolourpaint-3.5.0_beta2.ebuild,v 1.1 2005/10/14 18:41:56 danarmak Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Paint Program for KDE"
KEYWORDS="~amd64"
IUSE=""

# The setCustomAuthorText function seems to have been removed.
PATCHES="$FILESDIR/${P}-compile-fix.patch"
