# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vi/vi-3.7-r4.ebuild,v 1.4 2004/01/04 17:13:09 seemant Exp $

IUSE=""

MY_P=ex-020403
S=${WORKDIR}/${MY_P}
DESCRIPTION="The original VI package"
SRC_URI="http://download.berlios.de/ex-vi/${MY_P}.tar.gz"
HOMEPAGE="http://ex-vi.berlios.de/"
LICENSE="Caldera"
SLOT="0"
KEYWORDS="x86 ppc sparc arm mips alpha hppa"

# NOTE: vi needs /etc/termcap to function properly with TERM=linux.
DEPEND="sys-libs/ncurses
	=sys-libs/libtermcap-compat-1.2.3*"

PROVIDE="virtual/editor"

src_compile() {
	addpredict /dev/ptys/*

	# Do not use TERMLIB=ncurses, as it causes vi
	# to segfault with TERM=linux.
	#
	# WARN is set in the environment in /sbin/functions.sh
	# (unfortunately generic variable name).  Need to reset on the
	# make command-line to keep from breaking the build.
	make DESTDIR=/usr \
		TERMLIB=termlib \
		PRESERVEDIR=/var/lib/expreserve \
		RECOVER="-DEXRECOVER=\\\"/var/lib/exrecover\\\" \
		         -DEXPRESERVE=\\\"/var/lib/expreserve\\\"" \
		WARN='' \
		|| die "failed compilation"
}

src_install() {
	local l

	dodir /usr/share/man
	keepdir /var/lib/{exrecover,expreserve}
	make INSTALL=/usr/bin/install \
		DESTDIR=${D}/usr \
		MANDIR=/share/man \
		TERMLIB=termlib \
		PRESERVEDIR=${D}/var/lib/expreserve \
		RECOVER="-DEXRECOVER=\\\"/var/lib/exrecover\\\" \
		         -DEXPRESERVE=\\\"/var/lib/expreserve\\\"" \
		install || die

	dodoc Changes LICENSE README TODO

	# By default this installs as ex with symlinks pointing to ex.
	# To reduce conflicts with other vi programs, change the master
	# program to vi, then point the symlinks at it.
	cd ${D}/usr/bin
	rm vi
	mv ex vi
	for l in *; do [ -L $l ] && ln -sfn vi $l; done
	ln -s vi ex
}
