# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/poster/poster-0.1.ebuild,v 1.1 2004/01/08 14:46:40 lanius Exp $

DESCRIPTION="small utility for making a poster from an EPS file or a one-page PS document"
SRC_URI="http://www.geocities.com/SiliconValley/5682/poster.tgz"
HOMEPAGE="http://www.geocities.com/SiliconValley/5682/poster.html"

LICENSE="poster"
KEYWORDS="~x86 ~amd64"
SLOT="0"

append-flags -lm

P=${PN}

src_compile(){
	tar xzf ${PN}.tar.gz
	gcc ${CFLAGS} -o poster poster.c
}

src_install() {
	dobin ${PN}
	doman ${PN}.1
}
