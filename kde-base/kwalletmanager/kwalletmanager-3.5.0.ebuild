# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwalletmanager/kwalletmanager-3.5.0.ebuild,v 1.6 2006/03/28 01:02:50 agriffis Exp $

KMNAME=kdeutils
KMMODULE=kwallet
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE Wallet Management Tool"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""