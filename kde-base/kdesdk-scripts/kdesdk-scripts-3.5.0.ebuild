# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk-scripts/kdesdk-scripts-3.5.0.ebuild,v 1.2 2005/12/12 19:23:49 josejx Exp $

KMNAME=kdesdk
KMMODULE="scripts"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Kdesdk Scripts - Some useful scripts for the development of applications"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""