# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdebase-pics/kdebase-pics-3.4.0_rc1.ebuild,v 1.2 2005/03/02 00:52:47 cryos Exp $

KMNAME=kdebase
KMMODULE=pics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Pics included with kdebase"
KEYWORDS="~x86 ~amd64"
IUSE=""

KMNODOCS=true
