# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dsniff/dsniff-2.3-r4.ebuild,v 1.1 2005/03/29 22:55:10 vanquirius Exp $

inherit eutils

# dsniff needs to build it's own version of sys-libs/db, since the one
# normally installed is for some reason unusable for dsniffs configure script.
# The version is chosen as being the standard one around at the time i wrote
# this ebuild, it's not set in stone.

DB_VER="3.2.9"

DESCRIPTION="A collection of tools for network auditing and penetration testing"
HOMEPAGE="http://monkey.org/~dugsong/dsniff/"
SRC_URI="http://www.sleepycat.com/update/snapshot/db-${DB_VER}.tar.gz
	http://monkey.org/~dugsong/${PN}/${P}.tar.gz"

# dsniff has it's own small license which is in the docs section
LICENSE="DSNIFF"
SLOT="0"
KEYWORDS="x86 ~alpha ~ppc"
IUSE=""

RDEPEND="virtual/libpcap
	<net-libs/libnet-1.1
	>=net-libs/libnet-1.0.2a-r3
	>=net-libs/libnids-1.18
	>=dev-libs/openssl-0.9.6e"
# dependencies only for building our own sys-libs/db
DEPEND="${RDEPEND}
	virtual/libc
	=sys-libs/db-1*
	sys-devel/libtool
	sys-devel/m4"

src_unpack() {
	unpack db-${DB_VER}.tar.gz
	unpack ${P}.tar.gz

	# Making sure data files get correctly installed and that dsniff
	# can find them
	# Working around dsniff b0rky config script
	# Data stuff goes into /etc/dsniff
	cd ${S}
	epatch ${FILESDIR}/${PV}-libnet-1.0.patch
	sed -i \
		-e 's:-ldb:-ldb -lpthread:' \
		-e "s:lib':':" \
		configure || die "sed configure"
	sed -i 's:-DDSNIFF_LIBDIR=\\\"$(libdir)/\\\"::' Makefile.in || die "sed makefile"
	sed -i 's:/usr/local/lib:/etc/dsniff:' pathnames.h || die "sed pathnames"
	epatch ${FILESDIR}/${PV}-makefile.patch
}

src_compile() {
	cd ${WORKDIR}/db-${DB_VER}/dist
	./configure \
		--host=${CHOST} \
		--enable-compat185 || die "./configure of db-${DB_VER} failed"
	emake || die "build of db-${DB_VER} failed"

	# Another workaround around the crappy config script
	cd ${S}
	econf --with-db=../db-${DB_VER} || die
	make || die
}

src_install() {
	make install install_prefix=${D} || die
	dodir /etc/dsniff
	mv ${D}/usr/{dnsspoof.hosts,dsniff.{magic,services}} ${D}/etc/dsniff/
	dodoc CHANGES README TODO
}
