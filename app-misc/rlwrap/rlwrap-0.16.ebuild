# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rlwrap/rlwrap-0.16.ebuild,v 1.1 2003/08/27 22:12:55 mkennedy Exp $

DESCRIPTION="rlwrap is a 'readline wrapper' which uses the GNU readline library to allow the editing of keyboard input for any command. Input history is remembered across invocations, separately for each command, history completion and -search work as in bash and completion word lists can be specified on the command line."
HOMEPAGE="http://utopia.knoware.nl/~hlub/uck/rlwrap/"
SRC_URI="http://utopia.knoware.nl/~hlub/uck/rlwrap/rlwrap-0.16.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/readline"

S=${WORKDIR}/${P}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS README 
}
