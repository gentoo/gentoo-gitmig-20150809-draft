# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/DBMix/DBMix-0.9.8.ebuild,v 1.1 2003/12/29 17:22:08 wmertens Exp $

DESCRIPTION="Mix several xmms and other sound streams like a DJ"
HOMEPAGE="http://dbmix.sourceforge.net"
SRC_URI="mirror://sourceforge/dbmix/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="xmms"

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
