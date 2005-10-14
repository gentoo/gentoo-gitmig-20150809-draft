# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/khexedit/khexedit-3.5.0_beta2.ebuild,v 1.1 2005/10/14 18:41:54 danarmak Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE hex editor"
KEYWORDS="~amd64"
IUSE=""

PATCHES="$FILESDIR/khexedit-configure-magic.diff"