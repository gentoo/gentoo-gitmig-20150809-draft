# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcharselect/kcharselect-3.4.0.ebuild,v 1.3 2005/03/25 03:57:54 weeve Exp $

KMNAME=kdeutils
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE character selection utility"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""

KMEXTRA="charselectapplet/"