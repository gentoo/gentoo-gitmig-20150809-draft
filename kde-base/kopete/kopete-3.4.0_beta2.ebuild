# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kopete/kopete-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:22 danarmak Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE multi-protocol IM client"
KEYWORDS="~x86"
IUSE="ssl"
DEPEND="!net-im/kopete"
RDEPEND="$DEPEND
	ssl? ( app-crypt/qca-tls )"
