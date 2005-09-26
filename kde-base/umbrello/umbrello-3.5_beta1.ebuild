# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/umbrello/umbrello-3.5_beta1.ebuild,v 1.2 2005/09/26 10:19:51 greg_g Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Umbrello UML Modeller"
KEYWORDS="~amd64"
IUSE=""

# Fix compilation. Applied for rc1.
PATCHES1="${FILESDIR}/kdesdk-3.5_beta1-compile.patch"
