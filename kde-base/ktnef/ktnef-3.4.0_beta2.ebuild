# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktnef/ktnef-3.4.0_beta2.ebuild,v 1.2 2005/02/09 21:59:53 motaboy Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Viewer for mail attachments using TNEF format"
KEYWORDS="~x86"
IUSE=""

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkdepim)"

