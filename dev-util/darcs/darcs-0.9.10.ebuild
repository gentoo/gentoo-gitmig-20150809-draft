# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/darcs/darcs-0.9.10.ebuild,v 1.2 2003/07/04 12:59:14 phosphan Exp $

DESCRIPTION="David's Advanced Revision Control System is yet another replacement for CVS"
HOMEPAGE="http://abridgegame.org/darcs"
SRC_URI="http://abridgegame.org/darcs/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=net-ftp/curl-7.10.2
	>=virtual/ghc-5.04
	doc?  ( >=app-text/tetex-2.0.2
		dev-tex/latex2html )"

RDEPEND=">=net-ftp/curl-7.10.2"

S=${WORKDIR}/${P}

src_compile() {
	# targets to make
	TARGETS="darcs darcs.1"
	if [ `use doc` ]; then
		TARGETS="${TARGETS} darcs.ps manual/index.html"
	fi
	sh ./configure --prefix=/usr
	make ${TARGETS} || die
}

src_install() {
	make DESTDIR=${D} install || die
	# correct documentation installation location
	cd ${D}/usr/share/doc
	mv darcs ${PF}
}
