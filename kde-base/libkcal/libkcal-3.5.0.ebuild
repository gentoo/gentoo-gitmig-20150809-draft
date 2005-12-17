# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcal/libkcal-3.5.0.ebuild,v 1.4 2005/12/17 09:39:18 corsair Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE kcal library for korganizer etc"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="
$(deprange $PV $MAXKDEVER kde-base/ktnef)"

KMCOPYLIB="libktnef ktnef/lib"
KMEXTRACTONLY="libkdepim/email.h"
KMCOMPILEONLY="libemailfunctions/"
