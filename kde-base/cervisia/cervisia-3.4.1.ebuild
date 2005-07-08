# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-3.4.1.ebuild,v 1.5 2005/07/08 05:11:37 weeve Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Cervisia - A KDE CVS frontend"
KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND="$DEPEND
	dev-util/cvs"