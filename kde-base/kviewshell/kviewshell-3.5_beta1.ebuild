# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kviewshell/kviewshell-3.5_beta1.ebuild,v 1.2 2005/10/22 07:39:44 halcy0n Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Generic framework for viewer applications"
KEYWORDS="~amd64 ~x86"
IUSE=""

PATCHES="${FILESDIR}/${PN}-qt-3.3.5.patch"

