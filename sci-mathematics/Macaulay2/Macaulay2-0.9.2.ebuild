# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/Macaulay2/Macaulay2-0.9.2.ebuild,v 1.3 2005/03/23 16:19:35 seemant Exp $

inherit eutils flag-o-matic toolchain-funcs

IUSE=""

DESCRIPTION="research tool for commutative algebra and algebraic geometry"
SRC_URI="http://www.math.uiuc.edu/Macaulay2/ftp-site/${P}-src.tar.gz \
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/Factory/factory-1.3b.tar.gz \
	ftp://www.mathematik.uni-kl.de/pub/Math/Singular/Libfac/libfac-0.3.2.tar.gz"

HOMEPAGE="http://www.math.uiuc.edu/Macaulay2/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

RDEPEND="sys-libs/gdbm
	dev-libs/gmp
	dev-libs/boehm-gc"

DEPEND="${RDEPEND}
	sys-apps/gawk
	dev-util/yacc"

src_compile() {
	if [ "$(gcc-version)" = "3.4" ]; then
		append-flags "-fno-unit-at-a-time" # gcc 3.4 bug #15114, phosphan
	fi
	cd ${WORKDIR}/factory
	epatch ${FILESDIR}/gentoo-factory-1.3b.diff
	./configure --disable-streamio --prefix=${WORKDIR} || die
	make || die
	make install || die

	cd ${WORKDIR}/libfac
	epatch ../Macaulay2-0.9.2/INSTALL.libfac-0.3.2-diffs
	./configure --prefix=${WORKDIR} || die
	make DEFS=-DHAVE_SINGULAR_ERROR || die
	make prefix=${WORKDIR} install || die

	cd ${WORKDIR}/include
	epatch ${FILESDIR}/gentoo-libfac-0.3.2.include.diff

	CXXFLAGS="${CXXFLAGS} -Wno-deprecated"
	filter-flags "-fomit-frame-pointer"

	cd ${WORKDIR}/Macaulay2-0.9.2
	epatch ${FILESDIR}/gentoo-Macaulay2-0.9.2.diff
	CPPFLAGS='-I/usr/include/gc -I${WORKDIR}/include' LDFLAGS=-L${WORKDIR}/lib \
	./configure --prefix=${D}/usr || die
	make || die
}

src_install () {
	cd ${WORKDIR}/Macaulay2-0.9.2
	einstall || die

	cp ${D}/usr/bin/M2-help tmp
	if has_version 'kde-base/kdebase' ; then
		einfo "Using konqueror as default help-browser!"
		sed "s:netscape:konqueror:g" < tmp > ${D}/usr/bin/M2-help
	elif has_version 'www-client/mozilla' ; then
		einfo "Using mozilla as default help-browser!"
		sed "s:netscape:mozilla:g" < tmp > ${D}/usr/bin/M2-help
	elif has_version 'www-client/mozilla-firefox' ; then
		einfo "Using mozilla-firefox as default help-browser!"
		sed "s:netscape:firefox:g" < tmp > ${D}/usr/bin/M2-help
	elif has_version 'www-client/epiphany' ; then
		einfo "Using epiphany as default help-browser!"
		sed "s:netscape:epiphany:g" < tmp > ${D}/usr/bin/M2-help
	else
		mv tmp ${D}/usr/bin/M2-help
	fi
	chmod a+x ${D}/usr/bin/M2-help

	einfo "To change the default help browser, please set the environment"
	einfo "variable WWBROWSER to the browser of your choice"

	rm ${D}/usr/libexec/*data*
}
