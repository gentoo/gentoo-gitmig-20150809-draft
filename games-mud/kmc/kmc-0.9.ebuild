# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kmc/kmc-0.9.ebuild,v 1.10 2005/04/24 03:18:40 hansmi Exp $

inherit kde flag-o-matic

append-flags -fpermissive

DESCRIPTION="A mud client for KDE"
HOMEPAGE="http://kmc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64 ~sparc"

SLOT="0"
IUSE=""

RDEPEND=">=dev-lang/perl-5.4"
need-kde 3
