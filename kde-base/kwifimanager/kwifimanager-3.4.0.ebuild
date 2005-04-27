# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwifimanager/kwifimanager-3.4.0.ebuild,v 1.3 2005/04/27 21:49:00 corsair Exp $

KMNAME=kdenetwork
KMMODULE=wifi
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE wifi (wireless network) gui"
KEYWORDS="~x86 ~amd64 ~ppc ~ppc64"
IUSE=""
DEPEND=">=net-wireless/wireless-tools-25"
KMEXTRA="doc/kwifimanager"