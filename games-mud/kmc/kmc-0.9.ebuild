# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kmc/kmc-0.9.ebuild,v 1.5 2004/06/25 20:07:01 centic Exp $

inherit kde flag-o-matic
append-flags -fpermissive
need-kde 3

DESCRIPTION="A mud client for KDE"
HOMEPAGE="http://kmc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"

SLOT="0"
IUSE=""

RDEPEND=">=dev-lang/perl-5.4"

