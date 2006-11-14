# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmid/kmid-3.5.5.ebuild,v 1.3 2006/11/14 01:14:58 kugelfang Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE midi player"
KEYWORDS="~alpha amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE=""