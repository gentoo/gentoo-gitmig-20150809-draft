# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/flite/flite-1.0-r1.ebuild,v 1.1 2004/03/18 07:03:29 eradicator Exp $

IUSE="static"

DESCRIPTION="Flite text to speech engine"
HOMEPAGE="http://www.speech.cs.cmu.edu/flite/index.html"
SRC_URI="http://www.speech.cs.cmu.edu/flite/packed/flite-1.0/${P}-beta.tar.gz"

SLOT="0"
LICENSE="X11"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die "Failed configuration"
	emake || die "Failed compilation"

	if ! use static; then
		cd ${S}/lib;
		for lib in lib*.a; do
			soname="${lib/.a/.so}"
			ld -shared --whole-archive -o ${soname} -soname ${soname} ${lib}
		done
	fi
}

src_install () {
	if use static; then
		dolib.a lib/lib*.a
	else
		dolib.so lib/lib*.so
	fi

	dobin bin/flite bin/flite_time
	dodoc ACKNOWLEDGEMENTS README

	insinto /usr/include
	doins include/*.h
}
