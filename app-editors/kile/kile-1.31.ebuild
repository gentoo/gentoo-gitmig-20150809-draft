# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.31.ebuild,v 1.2 2002/12/12 15:30:09 hannes Exp $
inherit kde-base

need-kde 3

IUSE=""
DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="http://perso.club-internet.fr/pascal.brachet/kile/${P}.tar.gz"
HOMEPAGE="http://perso.club-internet.fr/pascal.brachet/kile/"

DEPEND="$DEPEND sys-devel/perl"
RDEPEND="${RDEPEND} app-text/tetex"

KEYWORDS="~x86"
LICENSE="GPL-2"
