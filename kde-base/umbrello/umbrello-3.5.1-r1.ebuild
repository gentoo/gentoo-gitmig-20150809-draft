# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-3.5.1-r1.ebuild,v 1.3 2006/05/26 17:38:15 wolf31o2 Exp $

KMNAME=kdesdk
MAXKDEVER=3.5.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Umbrello UML Modeller"
KEYWORDS="amd64 ~ppc ~ppc64 x86"
IUSE=""

PATCHES="${FILESDIR}/${P}-fork.patch
	${FILESDIR}/${P}-fork-rectangle.patch"
