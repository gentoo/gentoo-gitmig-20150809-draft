# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lua/lua-4.0.ebuild,v 1.5 2002/07/22 08:03:00 george Exp $

S=${WORKDIR}/lua
DESCRIPTION="A powerful light-weight programming language designed for extending applications."
SRC_URI="http://www.lua.org/ftp/${PN}.tar.gz"
HOMEPAGE="http://www.lua.org/"

SLOT="0"
KEYWORDS="x86"
LICENSE="lua"


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
