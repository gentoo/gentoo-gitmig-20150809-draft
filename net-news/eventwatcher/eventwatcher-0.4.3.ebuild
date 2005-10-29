# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/eventwatcher/eventwatcher-0.4.3.ebuild,v 1.1 2005/10/29 20:53:27 eldad Exp $

inherit kde

DESCRIPTION="A KDE application which notifies about various events."
HOMEPAGE="http://eventwatcher.sourceforge.net/"
SRC_URI="mirror://sourceforge/eventwatcher/${P}.tar.bz2"
LICENSE="LGPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="|| ( kde-base/librss kde-base/kdenetwork )"

need-kde 3
