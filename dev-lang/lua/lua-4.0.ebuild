# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Larry Cow <larrycow@free.fr>
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lua/lua-4.0.ebuild,v 1.1 2002/04/25 01:57:00 rphillips Exp $

P="lua"
S=${WORKDIR}/${P}
DESCRIPTION="A powerful light-weight programming language designed for extending applications."
SRC_URI="http://www.lua.org/ftp/${P}.tar.gz"
HOMEPAGE="http://www.lua.org/"

DEPEND="virtual/glibc"
RDEPEND="virtual/glibc"

src_compile() {
	patch < ${FILESDIR}/lua-4.0-config.patch

	emake || die
	make so || die
}

src_install () {
	make \
			INSTALL_BIN=${D}/usr/bin  \
			INSTALL_MAN=${D}/usr/share/man/man1 \
			INSTALL_INC=${D}/usr/include \
			INSTALL_LIB=${D}/usr/lib \
			install || die
}
