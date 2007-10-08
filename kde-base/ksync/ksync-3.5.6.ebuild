# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksync/ksync-3.5.6.ebuild,v 1.4 2007/10/08 09:57:16 corsair Exp $

KMNAME=kdepim
MAXKDEVER=3.5.7
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE pda synchronizer"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkcal)"

RDEPEND="${DEPEND}"

KMCOPYLIB="
	libkcal libkcal"
KMEXTRACTONLY="
	libkcal/"
