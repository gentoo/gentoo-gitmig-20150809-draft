# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/dsniff/dsniff-2.3.ebuild,v 1.6 2003/09/05 23:40:08 msterret Exp $

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
KEYWORDS="x86 ~ppc ~alpha"

RDEPEND=">=net-libs/libpcap-0.7.1
	>=net-libs/libnet-1.0.2
	>=net-libs/libnids-1.16
	>=dev-libs/openssl-0.9.6e"

# dependencies only for building our own sys-libs/db
DEPEND="${RDEPEND}
	virtual/glibc
	=sys-libs/db-1.85-r1
	sys-devel/libtool
	sys-devel/m4"

S="${WORKDIR}/${P}"
IUSE=""

src_unpack() {
	unpack db-${DB_VER}.tar.gz
	unpack ${P}.tar.gz

	# Making sure data files get correctly installed and that dsniff
	# can find them
	# Working around dsniff b0rky config script
	# Data stuff goes into /etc/dsniff
	cd ${S}

	mv configure configure.orig
	sed "s:lib':':" configure.orig > configure
	chmod +x configure

	mv Makefile.in Makefile.in.orig
	sed 's:-DDSNIFF_LIBDIR=\\\"$(libdir)/\\\"::' Makefile.in.orig > Makefile.in

	mv pathnames.h pathnames.h.orig
	sed 's:/usr/local/lib:/etc/dsniff:' pathnames.h.orig > pathnames.h
}

src_compile() {
	cd ${WORKDIR}/db-${DB_VER}/dist
	./configure \
		--host=${CHOST} \
		--enable-compat185 || die "./configure of db-${DB_VER} failed"
	emake || die "build of db-${DB_VER} failed"

	# Another workaround around the crappy config script
	cd ${S}
	./configure \
		--host=${CHOST} \
		--with-db=../db-${DB_VER} \
		--exec-prefix=${D}/etc/dsniff \
		--bindir=${D}/usr/bin \
		--sbindir=${D}/usr/sbin \
		--datadir=${D}/usr/share/ \
		--infodir=${D}/usr/share/info \
		--mandir=${D}/usr/share/man || die "./configure failed"

	make || die
}

src_install () {
	make install || die

	dodoc CHANGES LICENSE README TODO
}
