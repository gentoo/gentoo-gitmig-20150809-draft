# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3cat/mp3cat-0.4.ebuild,v 1.3 2006/03/07 15:08:43 flameeyes Exp $

inherit toolchain-funcs

DESCRIPTION="mp3cat reads and writes MP3 files"
HOMEPAGE="http://tomclegg.net/mp3cat"
SRC_URI="http://tomclegg.net/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:cc -o:${CC} ${CFLAGS} ${LDFLAGS} -o:' Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin mp3cat mp3log mp3log-conf mp3dirclean mp3http mp3stream-conf
}
