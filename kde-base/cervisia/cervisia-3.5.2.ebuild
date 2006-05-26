# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-3.5.2.ebuild,v 1.5 2006/05/26 15:19:57 wolf31o2 Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Cervisia - A KDE CVS frontend"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86"
IUSE=""

RDEPEND="$DEPEND
	dev-util/cvs"
HOMEPAGE="http://cervisia.kde.org"

