# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-1.3.ebuild,v 1.3 2004/03/12 09:18:43 mr_bones_ Exp $

inherit kde
need-kde 3

IUSE=""
DESCRIPTION="BibleTime KDE Bible study application using the SWORD library."
HOMEPAGE="http://bibletime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
S="${WORKDIR}/${P/_/}"

newdepend ">=app-text/sword-1.5.6"
