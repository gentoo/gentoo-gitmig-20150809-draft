# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/root/root-3.03.04-r2.ebuild,v 1.3 2003/06/12 16:57:45 seemant Exp $

inherit flag-o-matic eutils

S=${WORKDIR}/${PN}
DESCRIPTION="An Object-Oriented Data Analysis Framework"
SRC_URI="ftp://root.cern.ch/root/root_v${PV}.source.tar.gz"
HOMEPAGE="http://root.cern.ch/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ~ppc"
IUSE="mysql postgres opengl"

DEPEND="virtual/x11
	>=media-libs/freetype-2.0.9
	opengl? ( virtual/opengl virtual/glu )
	mysql? ( >=dev-db/mysql-3.23.49 )
	postgres? ( >=dev-db/postgresql-7.1.3-r4 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/root-makefile.patch
	epatch ${FILESDIR}/pgsql-no-libpq-int.patch
}

src_compile() {

	case $SYSTEM_ARCH in
		ppc)
			append-flags "-fsigned-char";;
	esac
	export GENTOO_CFLAGS="${CFLAGS}" GENTOO_CXXFLAGS="${CXXFLAGS}" 
	./configure \
		linux \
		--prefix=/usr \
		--docdir=/usr/share/doc/${P} \
		--enable-shared \
		--disable-rpath \
		--enable-thread \
		--enable-star \
		--enable-ttf \
		--disable-cern \
		--disable-sapdb \
		--disable-rfio \
		--disable-dcache \
		--disable-srp \
		--disable-afs \
		--disable-krb5 \
		--enable-shadowpw \
		--disable-pythia \
		--disable-pythia6 \
		--disable-venus \
		--enable-soversion \
		`use_enable opengl` \
		`use_enable mysql` \
		`use_enable postgres pgsql` \
		${myconf} || die "./configure failed"
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	
	dodir /etc/env.d
	echo "LDPATH=/usr/lib/root" > ${D}/etc/env.d/60root
}
