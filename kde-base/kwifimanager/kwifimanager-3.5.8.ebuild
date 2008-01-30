# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwifimanager/kwifimanager-3.5.8.ebuild,v 1.4 2008/01/30 17:23:28 ranger Exp $

KMNAME=kdenetwork
KMMODULE=wifi
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE wifi (wireless network) gui"
KEYWORDS="amd64 ~ppc ppc64 x86"
IUSE="kdehiddenvisibility"
DEPEND="net-wireless/wireless-tools"

RDEPEND="${DEPEND}"

KMEXTRA="doc/kwifimanager"
