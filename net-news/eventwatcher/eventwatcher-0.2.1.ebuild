# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/eventwatcher/eventwatcher-0.2.1.ebuild,v 1.3 2004/03/18 15:46:19 dholm Exp $

inherit kde
need-kde 3

DEPEND="kde-base/kdenetwork"

DESCRIPTION="EventWatcher is a KDE application which notifies about various events."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://eventwatcher.sourceforge.net/"

LICENSE="LGPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

IUSE=""
SLOT="0"

