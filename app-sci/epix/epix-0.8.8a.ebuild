# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/epix/epix-0.8.8a.ebuild,v 1.4 2003/05/09 18:33:49 latexer Exp $

DESCRIPTION="2- and 3-D plotter for creating images (to be used in LaTeX)"
HOMEPAGE="http://mathcs.holycross.edu/~ahwang/current/ePiX.html"

SRC_URI="http://mathcs.holycross.edu/~ahwang/software/${P}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="app-shells/bash"
	

src_unpack() {
	unpack ${A}
	cd ${S}

	# Some sedding to get things installed in the proper places.

	mv Makefile ${T}
	sed -e "s:CXX=g++:CXX=${CXX}:" \
		-e "s:CFLAGS=-c -Wall:CFLAGS=-c -Wall ${CFLAGS}:" \
		-e "s:prefix=/usr/local:prefix=${D}/usr:" \
		-e "s:share/epix:share/${P}:" \
		-e "s:/man/man1:/share/man/man1:" \
			${T}/Makefile > Makefile

	mv helpfiles.sh ${T}
	sed -e "s:\${EPIX_SHAREDIR}/epix:\${EPIX_SHAREDIR}/${P}:" \
			${T}/helpfiles.sh > helpfiles.sh
	chmod a+x helpfiles.sh

	mv pre-install.sh ${T}
	sed -e "s:man man/man1 share:share share/man share/man/man1:" \
		-e "s:share/epix:share/${P}:g" \
			${T}/pre-install.sh > pre-install.sh
	chmod a+x pre-install.sh

	mv -f prepix ${T}
	sed -e "s:^INSTALL_DIR.*:INSTALL_DIR=/usr:" \
		${T}/prepix > prepix
	chmod a+x prepix
}

src_compile() {
	emake || die
	emake contrib ||die
}

src_install() {
	make install || die
}
