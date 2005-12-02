# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.5_rc6-r1.ebuild,v 1.11 2005/12/02 23:19:03 jer Exp $

inherit eutils toolchain-funcs

MY_PV="${PV/_/-}a"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/js-${MY_PV}.tar.gz"

LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/js/src/

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-va_copy-fix.patch || die 'Patching failed.'
}

src_compile() {
	cat >>Makefile.ref<<'EOF'

.PHONY: install-headers
install-headers: $(HFILES)
	install -g root -o root -m 555 -d $(DESTDIR)/usr/include/js
	install -g root -o root -m 444 $^ $(DESTDIR)/usr/include/js
EOF

	export MY_CC="$(tc-getCC)"
	export MY_LD="$(tc-getLD)"
	export MY_AR="$(tc-getAR)"

	do_my_compile() {
		emake -j1 \
		-f Makefile.ref \
		BUILD_OPT=1 \
		CC="${MY_CC}" \
		LD="${MY_LD}" \
		AR="${MY_AR}"
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
		DESTDIR=${D} install-headers \
		CC="${MY_CC}" \
		LD="${MY_LD}" \
		AR="${MY_AR}" \
		|| die "make install-headers failed."

	dodoc ../README
	dohtml README.html
}
