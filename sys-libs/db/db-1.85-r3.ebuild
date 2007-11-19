# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/db/db-1.85-r3.ebuild,v 1.13 2007/11/19 06:48:19 kumba Exp $

inherit eutils toolchain-funcs multilib

DESCRIPTION="old berk db kept around for really old packages"
HOMEPAGE="http://www.sleepycat.com/"
SRC_URI="ftp://ftp.sleepycat.com/releases/db.${PV}.tar.gz
	mirror://gentoo/${PF}.1.patch.bz2"

LICENSE="DB"
SLOT="1"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/db.${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${WORKDIR}"/${PF}.1.patch
	epatch "${FILESDIR}"/${P}-gentoo-paths.patch
	sed -i \
		-e "s:@GENTOO_LIBDIR@:$(get_libdir):" \
		PORT/linux/Makefile || die
}

src_compile() {
	tc-export CC AR RANLIB
	emake -C PORT/linux OORG="${CFLAGS}" || die
}

src_install() {
	make -C PORT/linux install DESTDIR="${D}" || die

	# binary compat symlink
	dosym libdb1.so.2 /usr/$(get_libdir)/libdb.so.2 || die

	dosed "s:<db.h>:<db1/db.h>:" /usr/include/db1/ndbm.h
	dosym db1/ndbm.h /usr/include/ndbm.h

	dodoc changelog README
	newdoc hash/README README.hash
	docinto ps
	dodoc docs/*.ps
}
