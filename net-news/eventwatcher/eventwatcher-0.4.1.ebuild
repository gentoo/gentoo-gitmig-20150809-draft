# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/eventwatcher/eventwatcher-0.4.1.ebuild,v 1.4 2004/09/28 19:40:25 centic Exp $

inherit kde

DESCRIPTION="EventWatcher is a KDE application which notifies about various events."
HOMEPAGE="http://eventwatcher.sourceforge.net/"
SRC_URI="mirror://sourceforge/eventwatcher/${P}.tar.bz2"


SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ~sparc ~ppc ~amd64"
IUSE=""


DEPEND="kde-base/kdenetwork"
need-kde 3
