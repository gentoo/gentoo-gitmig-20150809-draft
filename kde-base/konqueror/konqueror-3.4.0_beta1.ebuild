# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/konqueror/konqueror-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:35 danarmak Exp $

KMNAME=kdebase
# Note: we need >=kdelibs-3.3.2-r1, but we don't want 3.3.3!
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Web browser, file manager, ..."
KEYWORDS="~x86"
IUSE=""

OLDDEPEND="~kde-base/libkonq-3.3.1"
DEPEND="
$(deprange-dual $PV $MAXKDEVER kde-base/libkonq)"

RDEPEND="${DEPEND}
$(deprange-dual $PV $MAXKDEVER kde-base/kcontrol)"
KMCOPYLIB="libkonq libkonq"
KMEXTRACTONLY=kdesktop/KDesktopIface.h

