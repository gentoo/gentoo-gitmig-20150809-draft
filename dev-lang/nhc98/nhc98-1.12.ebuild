# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/nhc98/nhc98-1.12.ebuild,v 1.10 2003/09/06 22:27:51 msterret Exp $

inherit eutils

DESCRIPTION="Haskell 98 compiler"
HOMEPAGE="http://www.cs.york.ac.uk/fp/nhc98/"
SRC_URI="ftp://ftp.cs.york.ac.uk/pub/haskell/nhc98/nhc98src-${PV}.tar.gz"

LICENSE="nhc98"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE="readline"

DEPEND="readline? ( >=readline-4.1 )"

src_unpack() {
	unpack ${A}
	# patch to fix the getenv bug when tracing
	cd ${P}
	epatch ${FILESDIR}/nhc98-1.12-getenv.patch
}

src_compile() {
	./configure --buildwith=gcc \
		--prefix=/usr --installdir=/usr \
		-man -docs \
		--buildopts="${CFLAGS} --host=${CHOST}" || die "./configure failed"
	# the build does not seem to work all that
	# well with parallel make
	make || die
}

src_install() {
	# The install location is taken care of by the
	# configure script.
	make DESTDIR=${D} install || die

	#nhc has really weir configure system:
	#it seems to setup hmakerc to point to the build position ignoring --prefix
	#just need to copy a proper hmakerc over here
	cd ${S}
	MACHINE=`script/harch`
	cp ${FILESDIR}/hmakerc ${D}/usr/lib/hmake/${MACHINE}/

	#install docs and man pages manually
	dodoc README INSTALL COPYRIGHT
	doman man/*

	cd docs
	dohtml *
	docinto html/bugs
	dodoc bugs/*
	docinto html/examples
	dodoc examples/*
	docinto html/hat
	dohtml hat/*
	docinto html/hmake
	dodoc hmake
	docinto html/implementation-notes
	dohtml implementation-notes/*
	docinto html/libs
	dohtml libs/*
}
