# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gtuxnes/gtuxnes-0.75.ebuild,v 1.3 2004/02/20 06:26:47 mr_bones_ Exp $

DESCRIPTION='GTK frontend for tuxnes, the emulator for the 8-bit Nintendo Entertainment System'
HOMEPAGE='http://www.scottweber.com/projects/gtuxnes/'
SRC_URI="http://www.scottweber.com/projects/gtuxnes/${P}.tar.gz"

LICENSE='GPL-2'
KEYWORDS='x86'
SLOT='0'
IUSE=''

DEPEND='x11-libs/gtk+
	>=sys-apps/sed-4'
RDEPEND='>=games-emulation/tuxnes-0.75'

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e 's/gcc/$(CC) $(CFLAGS)/' Makefile || \
			die 'sed Makefile failed'
}

src_compile() {
	emake || die 'emake failed'
}

src_install() {
	dobin gtuxnes

	# Install documentation
	dodoc AUTHORS CHANGES INSTALL README TODO
}
