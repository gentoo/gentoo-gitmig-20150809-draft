# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/eventwatcher/eventwatcher-0.3.ebuild,v 1.3 2004/06/25 00:24:58 agriffis Exp $

inherit kde
need-kde 3

DEPEND="kde-base/kdenetwork"

DESCRIPTION="EventWatcher is a KDE application which notifies about various events."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://eventwatcher.sourceforge.net/"

LICENSE="LGPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

IUSE=""
SLOT="0"

