# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcal/libkcal-3.4.1.ebuild,v 1.4 2005/07/01 09:17:28 corsair Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE kcal library for korganizer etc"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"
IUSE=""
OLDDEPEND="~kde-base/ktnef-$PV"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/ktnef)"

KMCOPYLIB="libktnef ktnef/lib"
KMEXTRACTONLY="libkdepim/email.h"
KMCOMPILEONLY="libemailfunctions/"
