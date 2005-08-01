# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.5_rc6-r1.ebuild,v 1.6 2005/08/01 18:52:40 josejx Exp $

inherit eutils

MY_PV="${PV/_/-}a"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/js-${MY_PV}.tar.gz"

LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/js/src/

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-${PV}-va_copy-fix.patch || die 'Patching failed.'
}

src_compile() {
	cat >>Makefile.ref<<'EOF'

.PHONY: install-headers
install-headers: $(HFILES)
	install -g root -o root -m 555 -d $(DESTDIR)/usr/include/js
	install -g root -o root -m 444 $^ $(DESTDIR)/usr/include/js
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
