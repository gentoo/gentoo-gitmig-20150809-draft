# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/styleclock/styleclock-0.5.1.ebuild,v 1.5 2007/02/09 16:25:42 masterdriverz Exp $

inherit kde eutils

DESCRIPTION="StyleClock is a better-looking replacement for the regular KDE clock. It is easily and flexibly themable and it comes with a built in alarm clock and countdown timer."
HOMEPAGE="http://fred.hexbox.de/styleclock/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"

need-kde 3.2
