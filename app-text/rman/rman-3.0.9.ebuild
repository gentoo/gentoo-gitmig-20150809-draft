# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: jim nutt <jim@nuttz.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/rman/rman-3.0.9.ebuild,v 1.1 2002/02/03 02:23:43 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="PolyGlotMan man page translator AKA RosettaMan"
A=rman.tar.gz
SRC_URI="http://polyglotman.sourceforge.net/${A}"
HOMEPAGE="http://polyglotman.sourceforge.net/"

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	patch -p0 <${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {
	emake CFLAGS="${CFLAGS} -finline-functions" || die
}

src_install () {
	dobin ${PN}
	doman ${PN}.1
}
