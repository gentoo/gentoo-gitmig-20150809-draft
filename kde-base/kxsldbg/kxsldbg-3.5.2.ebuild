# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kxsldbg/kxsldbg-3.5.2.ebuild,v 1.1 2006/03/22 20:15:41 danarmak Exp $
KMNAME=kdewebdev
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta flag-o-matic

DESCRIPTION="A KDE KPart Application for xsldbg, an XSLT debugger"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="dev-libs/libxslt
	dev-libs/libxml2"
