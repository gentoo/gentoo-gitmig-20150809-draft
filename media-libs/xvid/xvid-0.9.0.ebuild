# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Georgi Georgiev <chutz@chubaka.net>
# $Header: /var/cvsroot/gentoo-x86/media-libs/xvid/xvid-0.9.0.ebuild,v 1.8 2004/03/19 07:56:05 mr_bones_ Exp $

S="${WORKDIR}/${PN}core-${PV}"
DESCRIPTION="XviD, a high performance/quality MPEG-4 video de-/encoding solution."
SRC_URI="http://cvs.xvid.org/downloads/${PN}core-${PV}.tar.bz2"
HOMEPAGE="http://www.xvid.org/"

DEPEND="virtual/glibc
	x86? ( >=dev-lang/nasm-0.98.30 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

src_unpack() {
	unpack ${A}

	cd ${S}/build/generic || die
	if use ppc; then
		sed -e "s:^CC:#CC:" \
			-e "s:^LIBDIR:#LIBDIR:" \
			Makefile.linuxppc > Makefile
	elif use x86; then
		sed -e "s:^LIBDIR:#LIBDIR:" \
			-e "s:^CFLAGS +=:#CFLAGS +=:" \
			-e "s:^#CFLAGS += -D:CFLAGS += -D:" \
			Makefile.linuxx86 > Makefile
	elif use sparc; then
		sed -e "s:^CC:#CC:" \
			-e "s:^CFLAGS = -fPIC -Wall -D:CFLAGS = -D:" \
			Makefile.sparc > Makefile
	fi
}

src_compile() {
	[ -z "${CC}" ] && export CC="gcc"

	cd ${S}/build/generic
	emake || die
}

src_install() {
	dolib.so ${S}/build/generic/libxvidcore.so
	dolib.a  ${S}/build/generic/libxvidcore.a

	insinto /usr/include
	doins src/xvid.h src/divx4.h src/encoder.h src/decoder.h

	dodoc authors.txt changelog.txt LICENSE README.txt todo.txt

	if [ "`use doc`" ]
	then
		dodoc CodingStyle doc/README doc/xvid-decoding.txt doc/xvid-encoder.txt
		insinto /usr/share/doc/${PF}/examples
		doins examples/*
		# Empty for this release ...
		#insinto /usr/share/doc/${PF}/examples/ex1
		#doins examples/ex1/*
	fi
}

