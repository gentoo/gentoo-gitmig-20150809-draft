# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.5_rc6.ebuild,v 1.1 2004/09/03 20:51:21 usata Exp $

MY_PV="${PV/_/-}a"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/js-${MY_PV}.tar.gz"

LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/js/src/

src_compile() {
	cat >>Makefile.ref<<'EOF'

.PHONY: install-headers
install-headers: $(JS_HFILES)
	install -g root -o root -m 555 -d $(DESTDIR)/usr/include
	install -g root -o root -m 444 $^ $(DESTDIR)/usr/include
EOF

	# it needs to run twice
	emake -j1 -f Makefile.ref BUILD_OPT=1 \
		|| emake -j1 -f Makefile.ref BUILD_OPT=1 || die
}

src_install() {
	cd Linux_All_OPT.OBJ
	dolib.a libjs.a || die "libjs.a failed"
	dolib.so libjs.so || die "libjs.so failed"
	dobin js jscpucfg || die "dobin failed"
	cd -

	make -f Makefile.ref DESTDIR=${D} install-headers \
		|| die "make install-headers failed."

	dodoc ../README
	dohtml README.html
}
