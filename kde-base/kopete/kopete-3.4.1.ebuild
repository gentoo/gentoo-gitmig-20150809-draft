# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-3.4.1.ebuild,v 1.1 2005/05/25 21:23:09 danarmak Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE multi-protocol IM client"
KEYWORDS="~x86 ~amd64"
IUSE="ssl"

RDEPEND="ssl? ( app-crypt/qca-tls )"

