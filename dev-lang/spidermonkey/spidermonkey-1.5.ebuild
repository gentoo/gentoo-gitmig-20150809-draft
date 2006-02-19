# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.5.ebuild,v 1.1 2006/02/19 03:46:57 vanquirius Exp $

inherit eutils toolchain-funcs

MY_P="js-${PV}"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/${MY_P}.tar.gz"

LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

S="${WORKDIR}/js/src"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-1.5_rc6-va_copy-fix.patch
}

src_compile() {
	cat >>Makefile.ref<<'EOF'

.PHONY: install-headers
install-headers: $(HFILES)
	install -g root -o root -m 555 -d $(DESTDIR)/usr/include/js
	install -g root -o root -m 444 $^ $(DESTDIR)/usr/include/js
EOF

	tc-export CC LD AR

	do_my_compile() {
		emake -j1 \
		-f Makefile.ref \
		BUILD_OPT=1
		return $?
	}

	# it needs to run twice
	{ do_my_compile || do_my_compile ;} || die
}

src_install() {
	cd Linux_All_OPT.OBJ
	dolib.a libjs.a || die "libjs.a failed"
	dolib.so libjs.so || die "libjs.so failed"
	dobin js jscpucfg || die "dobin failed"
	cd -

	make -f Makefile.ref \
		DESTDIR="${D}" install-headers \
		|| die "make install-headers failed."

	dodoc ../README
	dohtml README.html
}
