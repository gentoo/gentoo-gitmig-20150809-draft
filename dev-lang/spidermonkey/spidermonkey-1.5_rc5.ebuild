# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.5_rc5.ebuild,v 1.2 2003/06/23 19:53:34 vapier Exp $

inherit gcc flag-o-matic
[ "`gcc-fullversion`" == "3.2.2" ] && replace-flags -march=pentium4 -march=pentium3

MY_PV="${PV/_/-}"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
SRC_URI="ftp://ftp.mozilla.org/pub/js/js-${MY_PV}.tar.gz"

LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="~x86"

DEPEND=""

S=${WORKDIR}/js/src/

src_compile() {
	make -f Makefile.ref BUILD_OPT=1 || die
}

src_install() {
	dodoc ../README
	dohtml README.html
	cd Linux_All_OPT.OBJ
	dolib.a libjs.a
	dolib.so libjs.so
	dobin js jscpucfg
	insinto /usr/include
	doins jsautocfg.h
}
