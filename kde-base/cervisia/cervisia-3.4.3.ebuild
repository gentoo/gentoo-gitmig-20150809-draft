# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-3.4.3.ebuild,v 1.7 2006/04/23 10:23:04 flameeyes Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Cervisia - A KDE CVS frontend"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="$DEPEND
	dev-util/cvs"

HOMEPAGE="http://cervisia.kde.org"

