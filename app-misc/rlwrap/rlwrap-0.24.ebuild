# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rlwrap/rlwrap-0.24.ebuild,v 1.3 2007/01/05 04:24:23 flameeyes Exp $


DESCRIPTION="a 'readline wrapper' which uses the GNU readline lib to allow the editing of keyboard input for any command"
HOMEPAGE="http://utopia.knoware.nl/~hlub/uck/rlwrap/"
SRC_URI="http://utopia.knoware.nl/~hlub/uck/rlwrap/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
IUSE="debug"

DEPEND="sys-libs/readline"

src_compile() {
	econf $(use_enable debug)
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS BUGS ChangeLog INSTALL NEWS README
}
