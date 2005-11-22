# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror/konqueror-3.5.0.ebuild,v 1.1 2005/11/22 22:14:09 danarmak Exp $

KMNAME=kdebase
# Note: we need >=kdelibs-3.3.2-r1, but we don't want 3.3.3!
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Web browser, file manager, ..."
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="java"


DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkonq)"

RDEPEND="${DEPEND}
$(deprange $PV $MAXKDEVER kde-base/kcontrol)
$(deprange $PV $MAXKDEVER kde-base/kdebase-kioslaves)
java? ( >=virtual/jre-1.4 )"

KMCOPYLIB="libkonq libkonq"
KMEXTRACTONLY=kdesktop/KDesktopIface.h

