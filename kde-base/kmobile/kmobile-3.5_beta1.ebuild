# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmobile/kmobile-3.5_beta1.ebuild,v 1.2 2005/10/11 09:59:42 flameeyes Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE mobile devices manager"
KEYWORDS="~amd64"
IUSE=""
DEPEND="app-mobilephone/gnokii
	$(deprange $PV $MAXKDEVER kde-base/libkcal)"

KMCOPYLIB="libkcal libkcal"

