# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxsldbg/kxsldbg-3.4.1.ebuild,v 1.12 2005/08/08 21:36:59 kloeri Exp $
KMNAME=kdewebdev
MAXKDEVER=3.4.2
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta flag-o-matic

DESCRIPTION="A KDE KPart Application for xsldbg, an XSLT debugger"
KEYWORDS="~alpha amd64 ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"

# Remove this when libxslt-1.1.14-r1 goes stable (#98345)
append-flags -DFORCE_DEBUGGER
