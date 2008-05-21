# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/root/root-3.05.04.ebuild,v 1.5 2008/05/21 19:02:38 dev-zero Exp $

inherit flag-o-matic eutils

S=${WORKDIR}/${PN}
DESCRIPTION="An Object-Oriented Data Analysis Framework"
SRC_URI="ftp://root.cern.ch/root/root_v${PV}.source.tar.gz"
HOMEPAGE="http://root.cern.ch/"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 sparc ppc"
IUSE="mysql postgres opengl"

RDEPEND="x11-libs/libXpm
	>=media-libs/freetype-2.0.9
	opengl? ( virtual/opengl virtual/glu )
	mysql? ( virtual/mysql )
	postgres? ( virtual/postgresql-server )"

DEPEND="${RDEPEND}
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#epatch ${FILESDIR}/root-makefile.patch
	#epatch ${FILESDIR}/pgsql-no-libpq-int.patch
}

src_compile() {

	case $SYSTEM_ARCH in
		ppc)
			append-flags "-fsigned-char";;
	esac
	#export GENTOO_CFLAGS="${CFLAGS}" GENTOO_CXXFLAGS="${CXXFLAGS}"
	./configure \
		linux \
		--prefix=/usr \
		--docdir=/usr/share/doc/${P} \
		--enable-shared \
		--disable-rpath \
		--enable-thread \
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
	make OPT="$CFLAGS" || die
}

src_install() {
	make DESTDIR="${D}" INSTALL="install" install || die

	dodir /etc/env.d
	echo "LDPATH=/usr/lib/root" > "${D}"/etc/env.d/60root
}
