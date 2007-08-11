# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwifimanager/kwifimanager-3.5.7.ebuild,v 1.6 2007/08/11 15:37:48 armin76 Exp $

KMNAME=kdenetwork
KMMODULE=wifi
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE wifi (wireless network) gui"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="kdehiddenvisibility"
DEPEND="net-wireless/wireless-tools"

RDEPEND="${DEPEND}"

KMEXTRA="doc/kwifimanager"
