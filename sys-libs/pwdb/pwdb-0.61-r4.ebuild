# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pwdb/pwdb-0.61-r4.ebuild,v 1.17 2003/09/12 01:58:42 vapier Exp $

inherit eutils flag-o-matic
filter-flags "-fstack-protector"

DESCRIPTION="Password database"
HOMEPAGE="http://www.firstlinux.com/cgi-bin/package/content.cgi?ID=6886"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD | GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ppc sparc alpha mips hppa arm"

DEPEND="virtual/glibc"

src_unpack () {
	mkdir ${S}
	cd ${S}
	unpack ${A}
	[ "${ARCH}" = "hppa" ] && epatch ${FILESDIR}/${P}-hppa.patch
}

src_compile() {
	# author has specified application to be compiled with `-g`
	# no problem, but with ccc `-g` disables optimisation to make
	# debugging easier, `-g3` enables debugging and optimisation
	[ "${ARCH}" = "alpha" -a "${CC}" = "ccc" ] && append-flags -g3
	cp Makefile Makefile.orig
	cp default.defs default.defs.orig
	sed -e "s/^DIRS = .*/DIRS = libpwdb/" -e "s:EXTRAS += :EXTRAS += ${CFLAGS} :" \
		Makefile.orig > Makefile
	sed -e "s/=gcc/=${CC:-gcc}/g" default.defs.orig > default.defs
	emake || die
}

src_install() {
	dodir /lib /usr/include/pwdb
	make INCLUDED=${D}/usr/include/pwdb \
		LIBDIR=${D}/lib \
		LDCONFIG="echo" \
		install || die

	preplib /
	dodir /usr/lib
	mv ${D}/lib/*.a ${D}/usr/lib

	# See bug $4411 for more info
	gen_usr_ldscript libpwdb.so

	insinto /etc
	doins conf/pwdb.conf

	dodoc CHANGES Copyright CREDITS README
	dohtml -r doc
	docinto txt
	dodoc doc/*.txt
}
