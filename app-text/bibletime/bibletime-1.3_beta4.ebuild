# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-1.3_beta4.ebuild,v 1.3 2003/07/11 20:35:22 aliz Exp $

inherit kde-base
need-kde 3
IUSE=""
DESCRIPTION="BibleTime KDE Bible study application using the SWORD library."
HOMEPAGE="http://bibletime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/_/}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
S="${WORKDIR}/${P/_/}"
DEPEND=">=app-text/sword-1.5.5"
