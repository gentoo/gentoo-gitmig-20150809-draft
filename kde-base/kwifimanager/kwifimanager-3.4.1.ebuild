# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwifimanager/kwifimanager-3.4.1.ebuild,v 1.3 2005/06/02 10:00:48 greg_g Exp $

KMNAME=kdenetwork
KMMODULE=wifi
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE wifi (wireless network) gui"
KEYWORDS="~x86 ~amd64 ~ppc64 ~ppc"
IUSE=""
DEPEND="<=net-wireless/wireless-tools-28_pre6"
KMEXTRA="doc/kwifimanager"
