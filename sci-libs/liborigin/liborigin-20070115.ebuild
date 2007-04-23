# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/liborigin/liborigin-20070115.ebuild,v 1.1 2007/04/23 16:12:07 bicatali Exp $

inherit toolchain-funcs multilib

DESCRIPTION="A library for reading OriginLab OPJ project files"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://sourceforge.net/projects/liborigin/"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

SLOT="0"
IUSE=""

DEPEND="!sci-visualization/labplot"
RESTRICT="test"

src_compile() {
	# the Makefile.LINUX is very basic, and *both* (and the only) "action" lines
	# need to be adjusted. It is easier to simply build stuff in a proper way
	# directly here.
	$(tc-getCXX) \
		${CXXFLAGS} \
		OPJFile.cpp \
		-shared -Wl,-soname,liborigin.so.0 -fPIC \
		-o liborigin.so.0.0.1 || die "lib compilation failed"
	$(tc-getCXX) \
		${CXXFLAGS} \
		opj2dat.cpp OPJFile.cpp \
		-o opj2dat || die "exec compilation failed"
}

src_install() {
	dolib liborigin.so.0.0.1 || die "dolib failed"
	dosym liborigin.so.0.0.1 /usr/$(get_libdir)/liborigin.so.0
	dosym liborigin.so.0 /usr/$(get_libdir)/liborigin.so
	dobin opj2dat || die "dobin failed"
	dodoc README ws4.opj || die "dodoc failed"
	insinto /usr/include
	doins OPJFile.h || die "doins failed"
}
