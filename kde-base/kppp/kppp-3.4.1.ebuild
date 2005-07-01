# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kppp/kppp-3.4.1.ebuild,v 1.4 2005/07/01 14:23:18 corsair Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: A dialer and front-end to pppd"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"
IUSE=""