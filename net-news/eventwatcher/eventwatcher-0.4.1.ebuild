# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/eventwatcher/eventwatcher-0.4.1.ebuild,v 1.5 2005/01/15 00:12:01 danarmak Exp $

inherit kde

DESCRIPTION="EventWatcher is a KDE application which notifies about various events."
HOMEPAGE="http://eventwatcher.sourceforge.net/"
SRC_URI="mirror://sourceforge/eventwatcher/${P}.tar.bz2"


SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ~sparc ~ppc ~amd64"
IUSE=""


DEPEND="|| ( kde-base/kdenetwork-meta kde-base/kdenetwork )"
need-kde 3
