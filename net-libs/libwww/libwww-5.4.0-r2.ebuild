# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libwww/libwww-5.4.0-r2.ebuild,v 1.3 2003/12/12 07:01:24 usata Exp $

IUSE="ssl mysql"

inherit libtool

MY_P=w3c-${P}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A general-purpose client side WEB API"
SRC_URI="http://www.w3.org/Library/Distribution/${MY_P}.tgz"
HOMEPAGE="http://www.w3.org/Library/"

SLOT="0"
LICENSE="W3C"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

RDEPEND="dev-lang/perl
	>=sys-libs/zlib-1.1.4
	mysql? ( >=dev-db/mysql-3.23.26 )
	ssl? ( >=dev-libs/openssl-0.9.6 )"

DEPEND="!dev-libs/9libs
	>=sys-devel/autoconf-2.13
	${RDEPEND}"

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff
	# patch for libwww-config library ordering
	# see bug #30185 for one instance <obz@gentoo.org>
	cd ${S}
	epatch ${FILESDIR}/${PN}-config-liborder.patch

}

src_compile() {

	elibtoolize

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

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYRIGH ChangeLog
	dohtml -r .
}
