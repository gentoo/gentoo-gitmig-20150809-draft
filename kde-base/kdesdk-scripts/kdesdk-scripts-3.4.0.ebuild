# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-3.4.0.ebuild,v 1.3 2005/03/26 01:38:00 weeve Exp $

KMNAME=kdesdk
KMMODULE="scripts"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Kdesdk Scripts - Some useful scripts for the development of applications"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE=""