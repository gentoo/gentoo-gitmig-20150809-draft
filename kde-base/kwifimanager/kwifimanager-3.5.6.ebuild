# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwifimanager/kwifimanager-3.5.6.ebuild,v 1.2 2007/07/11 01:08:48 mr_bones_ Exp $

KMNAME=kdenetwork
KMMODULE=wifi
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE wifi (wireless network) gui"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="kdehiddenvisibility"
DEPEND="net-wireless/wireless-tools"

RDEPEND="${DEPEND}"

KMEXTRA="doc/kwifimanager"
