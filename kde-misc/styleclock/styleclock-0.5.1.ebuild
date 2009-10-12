# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/styleclock/styleclock-0.5.1.ebuild,v 1.6 2009/10/12 07:14:42 abcd Exp $

inherit kde eutils

DESCRIPTION="StyleClock is a better-looking themable replacement for the regular KDE clock with alarm and timer"
HOMEPAGE="http://fred.hexbox.de/styleclock/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

need-kde 3.2
