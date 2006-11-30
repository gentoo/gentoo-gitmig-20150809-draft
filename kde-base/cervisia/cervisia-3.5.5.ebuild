# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/cervisia/cervisia-3.5.5.ebuild,v 1.7 2006/11/30 09:11:02 corsair Exp $

KMNAME=kdesdk
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="Cervisia - A KDE CVS frontend"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="${RDEPEND}
	dev-util/cvs"
HOMEPAGE="http://cervisia.kde.org"

