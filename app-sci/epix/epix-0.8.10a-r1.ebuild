# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/epix/epix-0.8.10a-r1.ebuild,v 1.7 2004/11/24 03:09:53 ribosome Exp $

inherit toolchain-funcs

DESCRIPTION="2- and 3-D plotter for creating images (to be used in LaTeX)"
HOMEPAGE="http://mathcs.holycross.edu/~ahwang/current/ePiX.html"
SRC_URI="http://mathcs.holycross.edu/~ahwang/software/${P}_complete.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="virtual/tetex"

RDEPEND="app-shells/bash
		>=sys-apps/sed-4"

S=${WORKDIR}/${P/a/}


src_unpack() {
	unpack ${A}
	cd ${S}

	# Some sedding to get things installed in the proper places.

	sed -i -e "s:\${EPIX_SHAREDIR}/epix:\${EPIX_SHAREDIR}/${P}:" \
			helpfiles.sh

	sed -i -e "s:man man/man1 share:share share/man share/man/man1:;\
		      s:share/epix:share/${P}:g"  pre-install.sh
	chmod a+x pre-install.sh

	sed -i -e "s:^INSTALL_DIR.*:INSTALL_DIR=/usr:" prepix
}

src_compile() {
	emake CXX="$(tc-getCXX)" CFLAGS="-c ${CFLAGS}" shrdir=${D}/usr/share\
			mandir=${D}/usr/share/man/man1 epix contrib || die
	echo > README.gentoo -e "The full documentation is well hidden in the epix*howto.ps.gz-file in the tutorial subdirectory"
}

src_install() {
	dodir /usr/man/man1
	make "prefix=${D}/usr/" install || die
	dodoc README.gentoo
	cd ${D}/usr/share/${PN}-${PV}
	dodoc notes/*
	rm -rf notes
	docinto tutorial
	dodoc tutorial/*
	docinto tutorial/contrib
	dodoc tutorial/contrib/*
	rm -rf tutorial
}
