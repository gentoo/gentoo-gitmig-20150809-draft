# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/rfksay/rfksay-0.1.ebuild,v 1.1 2004/01/03 23:12:37 vapier Exp $

inherit games

DESCRIPTION="Like cowsay, but different because it involves robots and kittens"
HOMEPAGE="http://www.redhotlunix.com/"
SRC_URI="http://www.redhotlunix.com/${PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"

DEPEND="dev-lang/perl"

S=${WORKDIR}

src_install() {
	dogamesbin kittensay rfksay robotsay
}
