# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/DBMix/DBMix-0.9.8.ebuild,v 1.6 2006/06/16 21:22:59 flameeyes Exp $

IUSE="xmms"

DESCRIPTION="Mix several xmms and other sound streams like a DJ"
HOMEPAGE="http://dbmix.sourceforge.net"
SRC_URI="mirror://sourceforge/dbmix/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
# -amd64: looks like sizeof() problems... sound plays but "skippy"
# -sparc: fails to initialize.  xmms plugin segfaults xmms on exit
KEYWORDS="x86 -amd64 -sparc"

DEPEND="x11-libs/gtk+
	xmms? ( media-sound/xmms )"
RDEPEND="x11-libs/gtk+"

src_unpack() {
	unpack ${A}
	cd ${S}

	einfo "Fixing errno naming"
	find . -type f -name \*.c \
		-exec grep -q 'int errno' '{}' \; \
		-exec sed -i~ 's/extern int errno;/#include <errno.h>/' '{}' \; \
		|| die
	einfo "Fixing library calling"
	find . -type f -name Makefile\* \
		-exec grep -q -- -ldbaudiolib '{}' \; \
		-exec sed -i~ 's:-ldbaudiolib:-L../dbaudiolib/.libs &:' '{}' \; \
		|| die
	einfo "Fixing all about.c strings"
	find . -type f -name about.c \
		-exec sed -i~ 's:\\n *$:\\n\\:' '{}' \; \
		|| die
	einfo "Fixing naked . in include"
	sed -i~ 's/^INCLUDES = ./INCLUDES = -I./' dbfsd_src/Makefile* \
		|| die
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install() {
	# Without the AM_MAKEFLAGS, it doesn't seem to pass DESTDIR
	make DESTDIR=${D} AM_MAKEFLAGS="DESTDIR=${D}" install || die
	dodoc README Readme*
}
