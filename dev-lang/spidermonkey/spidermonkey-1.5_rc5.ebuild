# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.5_rc5.ebuild,v 1.6 2004/04/19 19:12:46 vapier Exp $

MY_PV="${PV/_/-}"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
SRC_URI="ftp://ftp.mozilla.org/pub/js/js-${MY_PV}.tar.gz"

LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="x86"

DEPEND=""

S=${WORKDIR}/js/src/

src_compile() {
	make -f Makefile.ref BUILD_OPT=1 || die
}

src_install() {
	dodoc ../README
	dohtml README.html
	cd Linux_All_OPT.OBJ
	dolib.a libjs.a || die "libjs.a failed"
	dolib.so libjs.so || die "libjs.so failed"
	dobin js jscpucfg || die "dobin failed"
	insinto /usr/include
	doins jsautocfg.h
}
