# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/metamonitor/metamonitor-0.4.5.ebuild,v 1.1 2007/04/07 16:17:58 jokey Exp $

inherit kde

DESCRIPTION="Log monitoring tool for KDE."
SRC_URI="mirror://sourceforge/metamonitor/${P}.tar.bz2"
HOMEPAGE="http://metamonitor.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

need-kde 3.3