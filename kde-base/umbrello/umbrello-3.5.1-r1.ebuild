# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-3.5.1-r1.ebuild,v 1.8 2006/12/01 20:11:27 flameeyes Exp $

KMNAME=kdesdk
MAXKDEVER=3.5.3
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Umbrello UML Modeller"
KEYWORDS="alpha amd64 ppc ppc64 x86"
IUSE="kdehiddenvisibility"

PATCHES="${FILESDIR}/${P}-fork.patch
	${FILESDIR}/${P}-fork-rectangle.patch"
