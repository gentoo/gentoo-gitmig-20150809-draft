# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/drkonqi/drkonqi-3.4.0.ebuild,v 1.3 2005/03/21 04:00:25 weeve Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE crash handler gives the user feedback if a program crashed"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""


