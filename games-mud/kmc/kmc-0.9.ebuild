# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/kmc/kmc-0.9.ebuild,v 1.1 2003/09/10 19:03:12 vapier Exp $

inherit kde
need-kde 3

DESCRIPTION="A mud client for KDE"
HOMEPAGE="http://kmc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

RDEPEND=">=dev-lang/perl-5.4"
