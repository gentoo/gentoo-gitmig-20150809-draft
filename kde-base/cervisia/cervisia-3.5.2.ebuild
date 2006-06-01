# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-3.5.2.ebuild,v 1.8 2006/06/01 05:23:39 tcort Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Cervisia - A KDE CVS frontend"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="$DEPEND
	dev-util/cvs"
HOMEPAGE="http://cervisia.kde.org"

