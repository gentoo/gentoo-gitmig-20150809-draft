# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwifimanager/kwifimanager-3.4.0.ebuild,v 1.2 2005/03/18 17:11:24 morfic Exp $

KMNAME=kdenetwork
KMMODULE=wifi
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE wifi (wireless network) gui"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND=">=net-wireless/wireless-tools-25"
KMEXTRA="doc/kwifimanager"