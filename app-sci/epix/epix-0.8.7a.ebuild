# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/epix/epix-0.8.7a.ebuild,v 1.1 2003/02/14 16:28:29 latexer Exp $

DESCRIPTION="2- and 3-D plotter for creating images (to be used in LaTeX)"
HOMEPAGE="http://mathcs.holycross.edu/~ahwang/current/ePiX.html"

SRC_URI="ftp://ftp.ibiblio.org/${P}_src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="sys-apps/bash"


src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile ${T}
	sed -e "s:CXX=g++:CXX=${CXX}:" \
		-e "s:CFLAGS=-c -Wall:CFLAGS=-c -Wall ${CFLAGS}:" \
		-e "s:prefix=/usr/local:prefix=${D}/usr:" \
		-e "s:share/epix:share/${P}:" \
		-e "s:/man/man1:/share/man/man1:" \
			${T}/Makefile > Makefile

	mv helpfiles.sh ${T}
	sed -e "s:\${EPIX_SHARE}/epix:\${EPIX_SHARE}/${P}:" \
			${T}/helpfiles.sh > helpfiles.sh
	chmod a+x helpfiles.sh

	mv pre-install.sh ${T}
	sed -e "s:man man/man1:share share/man share/man/man1:" \
		-e "s:share share/epix:share/${P}:" \
			${T}/pre-install.sh > pre-install.sh
	chmod a+x pre-install.sh
}

src_compile() {
	emake || die
	emake contrib ||die
	#make || die
}

src_install() {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles.
	make install || die
	#doman epix.1
	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.

	# The portage shortcut to the above command is simply:
	#
	#einstall
}
