# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksystraycmd/ksystraycmd-3.4.0.ebuild,v 1.3 2005/03/21 03:52:12 weeve Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE: Allows any application to be kept in the system tray"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""


