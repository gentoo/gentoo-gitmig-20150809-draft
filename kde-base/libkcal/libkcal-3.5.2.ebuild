# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkcal/libkcal-3.5.2.ebuild,v 1.1 2006/03/22 20:15:41 danarmak Exp $

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
