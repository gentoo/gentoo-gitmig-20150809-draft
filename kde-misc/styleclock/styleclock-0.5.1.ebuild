# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/styleclock/styleclock-0.5.1.ebuild,v 1.1 2005/01/15 17:24:10 centic Exp $

inherit kde eutils

DESCRIPTION="StyleClock is a better-looking replacement for the regular KDE clock. It is easily and flexibly themable and it comes with a built in alarm clock and countdown timer."
HOMEPAGE="http://fred.hexbox.de/styleclock/"
SRC_URI="http://fred.hexbox.de/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

need-kde 3.2
