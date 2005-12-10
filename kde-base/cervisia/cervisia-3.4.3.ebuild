# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-3.4.3.ebuild,v 1.6 2005/12/10 07:31:09 chriswhite Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Cervisia - A KDE CVS frontend"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="$DEPEND
	dev-util/cvs"
