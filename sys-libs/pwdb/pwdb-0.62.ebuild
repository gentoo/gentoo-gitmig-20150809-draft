# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pwdb/pwdb-0.62.ebuild,v 1.18 2004/11/12 21:08:18 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Password database"
HOMEPAGE="http://www.firstlinux.com/cgi-bin/package/content.cgi?ID=6886"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://nl.lunar-linux.org/lunar/sources/sources/${P}.tar.gz"

LICENSE="|| ( BSD GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE="selinux"

DEPEND="virtual/libc
	selinux? ( sys-libs/libselinux )"

src_unpack () {
	unpack ${A}

	cd ${S}
	# Uses gcc as linker needed for hppa, but good idea in general.
	epatch ${FILESDIR}/${P}-use-gcc-as-linker.patch

	use selinux && epatch ${FILESDIR}/${P}-selinux.patch

	sed -i \
		-e "s/^DIRS = .*/DIRS = libpwdb/" \
		-e "s:EXTRAS += :EXTRAS += ${CFLAGS} :" \
		Makefile
	sed -i -e "s/=gcc/=$(tc-getCC)/g" default.defs
}

src_compile() {
	filter-flags -fstack-protector

	# author has specified application to be compiled with `-g` 
	# no problem, but with ccc `-g` disables optimisation to make
	# debugging easier, `-g3` enables debugging and optimisation
	[ "${ARCH}" = "alpha" -a "${CC}" = "ccc" ] && append-flags -g3

	emake || die
}

src_install() {
	dodir /lib /usr/include/pwdb
	make \
		INCLUDED=${D}/usr/include/pwdb \
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

	dodoc CHANGES CREDITS README
	dohtml -r doc
	docinto txt
	dodoc doc/*.txt
}
