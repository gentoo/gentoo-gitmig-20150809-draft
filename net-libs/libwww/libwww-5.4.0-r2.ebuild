# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libwww/libwww-5.4.0-r2.ebuild,v 1.4 2004/02/09 02:01:32 vapier Exp $

inherit libtool eutils

MY_P=w3c-${P}
DESCRIPTION="A general-purpose client side WEB API"
HOMEPAGE="http://www.w3.org/Library/"
SRC_URI="http://www.w3.org/Library/Distribution/${MY_P}.tgz
	mirror://gentoo/libwww-5.4.0-debian-autoconf-2.5.patch.bz2"

LICENSE="W3C"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE="ssl mysql"

RDEPEND="dev-lang/perl
	>=sys-libs/zlib-1.1.4
	mysql? ( >=dev-db/mysql-3.23.26 )
	ssl? ( >=dev-libs/openssl-0.9.6 )"
DEPEND="!dev-libs/9libs
	>=sys-devel/autoconf-2.13
	${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-config-liborder.patch
	epatch ${WORKDIR}/${P}-debian-autoconf-2.5.patch

	elibtoolize
	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
}

src_compile() {
	econf \
		--enable-shared \
		--enable-static \
		--with-zlib \
		--with-md5 \
		--with-expat \
		`use_with mysql` \
		`use_with ssl` \
		|| die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc COPYRIGH ChangeLog
	dohtml -r .
}
