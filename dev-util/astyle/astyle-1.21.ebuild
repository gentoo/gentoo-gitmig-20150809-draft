# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils

DESCRIPTION="Artistic Style is a reindenter and reformatter of C++, C and Java source code"
HOMEPAGE="http://astyle.sourceforge.net/"
SRC_URI="mirror://sourceforge/astyle/astyle_${PV}_linux.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE="debug libs"

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-${PV}-strip.patch
}

src_compile() {
	cd build
	local build_targets="release"
	if use debug; then
	    build_targets="debug"
	    if use libs; then
		build_targets="debug staticdebug shareddebug"
	    fi
	else
	    if use libs; then
		build_targets="release static shared"
	    fi
	fi
	make ${build_targets} || die "build failed"
}

src_install() {
	if use debug; then
	    newbin bin/astyled astyle
	    if use libs; then
		newlib.a bin/libastyled.a libastyle.a
		# shared lib needs at least a soname patch
		newlib.so bin/libastyled.so libastyle.so
	    fi
	else
	    if use libs; then
		dolib.a bin/libastyle.a
		dolib.so bin/libastyle.so
	    fi
	    dobin bin/astyle
	fi
	dohtml doc/*.html
}
