# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcal/libkcal-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:26 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE kcal library for korganizer etc"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND="~kde-base/ktnef-$PV"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/ktnef)"


KMCOPYLIB="libktnef ktnef/lib"
KMEXTRACTONLY="libkdepim/email.h"
KMCOMPILEONLY="libemailfunctions/"