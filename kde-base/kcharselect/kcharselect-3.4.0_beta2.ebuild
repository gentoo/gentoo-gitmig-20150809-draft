# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcharselect/kcharselect-3.4.0_beta2.ebuild,v 1.3 2005/03/07 16:36:22 cryos Exp $

KMNAME=kdeutils
MAXKDEVER=3.4.0_rc1
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE character selection utility"
KEYWORDS="~x86 ~amd64"
IUSE=""

KMEXTRA="charselectapplet/"