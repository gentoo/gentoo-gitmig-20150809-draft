# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/jove/jove-4.16.0.58.ebuild,v 1.2 2004/04/06 03:37:50 vapier Exp $

inherit eutils

DESCRIPTION="Jonathan's Own Version of Emacs -- a light emacs-like editor without LISP bindings"
HOMEPAGE="ftp://ftp.cs.toronto.edu/cs/ftp/pub/hugh/jove-dev/"
SRC_URI="http://ftp.debian.org/debian/pool/main/j/${PN}/${P/-/_}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/j/${PN}/${P/-/_}-1.diff.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE="X"

DEPEND="sys-libs/ncurses
	X? ( x11-libs/xview )"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/${PN}_${PV}-1.diff.gz

	sed -i \
		-e "s:^OPTFLAGS =.*:OPTFLAGS = ${CFLAGS}:" \
		-e "s:-ltermcap:-lncurses:" \
		Makefile
}

src_compile() {
	emake || die

	if use X ; then
		emake XJOVEJOME=/usr makexjove || die
	fi
}

src_install() {
	make DESTDIR=${D} install || die

	if use X ; then
		make DESTDIR=${D} XJOVEHOME=${D}/usr MANDIR=${D}/usr/share/man/man1 installxjove || die
	fi

	keepdir /var/lib/jove/preserve
}
