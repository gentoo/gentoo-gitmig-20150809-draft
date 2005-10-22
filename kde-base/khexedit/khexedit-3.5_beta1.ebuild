# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khexedit/khexedit-3.5_beta1.ebuild,v 1.2 2005/10/22 07:00:55 halcy0n Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE hex editor"
KEYWORDS="~amd64 ~x86"
IUSE=""

PATCHES="$FILESDIR/khexedit-configure-magic.diff"