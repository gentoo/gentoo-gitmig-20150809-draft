# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rlwrap/rlwrap-0.18.ebuild,v 1.1 2004/11/08 22:54:11 mkennedy Exp $

DESCRIPTION="a 'readline wrapper' which uses the GNU readline lib to allow the editing of keyboard input for any command"
HOMEPAGE="http://utopia.knoware.nl/~hlub/uck/rlwrap/"
SRC_URI="http://utopia.knoware.nl/~hlub/uck/rlwrap/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~mips"
IUSE=""

DEPEND="sys-libs/readline"

src_install() {
	einstall || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README
}
