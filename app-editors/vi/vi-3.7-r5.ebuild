# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/vi/vi-3.7-r5.ebuild,v 1.2 2004/01/04 17:14:05 seemant Exp $

IUSE=""

MY_P=ex-040103
S=${WORKDIR}/${MY_P}
DESCRIPTION="The original VI package"
HOMEPAGE="http://ex-vi.berlios.de/"
SRC_URI="http://ex-vi.berlios.de/archive/${MY_P}.tar.gz"
SLOT="0"
LICENSE="Caldera"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64 ~ppc64"

# NOTE: vi needs /etc/termcap to function properly with TERM=linux.
DEPEND="sys-libs/ncurses
	sys-libs/libtermcap-compat"

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
