# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.5.ebuild,v 1.1 2003/04/28 20:19:01 caleb Exp $
inherit kde-base

need-kde 3.1

IUSE=""
DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="http://perso.club-internet.fr/pascal.brachet/kile/${P}.tar.gz"
HOMEPAGE="http://perso.club-internet.fr/pascal.brachet/kile/"

DEPEND="$DEPEND dev-lang/perl"
RDEPEND="${RDEPEND} app-text/tetex"

KEYWORDS="~x86"
LICENSE="GPL-2"
