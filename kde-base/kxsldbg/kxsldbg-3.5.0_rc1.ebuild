# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxsldbg/kxsldbg-3.5.0_rc1.ebuild,v 1.1 2005/11/12 15:49:35 danarmak Exp $
KMNAME=kdewebdev
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta flag-o-matic

DESCRIPTION="A KDE KPart Application for xsldbg, an XSLT debugger"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"

# Remove this when libxslt-1.1.14-r1 goes stable (#98345)
append-flags -DFORCE_DEBUGGER
