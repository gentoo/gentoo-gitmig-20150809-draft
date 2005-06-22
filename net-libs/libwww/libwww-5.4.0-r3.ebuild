# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libwww/libwww-5.4.0-r3.ebuild,v 1.2 2005/06/22 17:58:20 herbs Exp $

inherit eutils multilib

MY_P=w3c-${P}
DESCRIPTION="A general-purpose client side WEB API"
HOMEPAGE="http://www.w3.org/Library/"
SRC_URI="http://www.w3.org/Library/Distribution/${MY_P}.tgz
	mirror://gentoo/libwww-5.4.0-debian-autoconf-2.5.patch.bz2"

LICENSE="W3C"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 ppc-macos s390 sparc x86"
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
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-config-liborder.patch
	epatch "${WORKDIR}"/${P}-debian-autoconf-2.5.patch
	epatch "${FILESDIR}"/${P}-autoconf-gentoo.diff
	epatch "${FILESDIR}"/${P}-automake-gentoo.diff	# bug #41959
	epatch "${FILESDIR}"/${P}-disable-ndebug-gentoo.diff	# bug #50483
	# http://lists.w3.org/Archives/Public/www-lib/2003OctDec/0015.html
	# http://www.mysql.gr.jp/mysqlml/mysql/msg/8118
	epatch "${FILESDIR}"/${P}-mysql-4.1.patch

	if use ppc-macos ; then
		glibtoolize -c -f || die "libtoolize failed"
	else
		libtoolize -c -f || die "libtoolize failed"
	fi

	aclocal || die "aclocal failed"
	autoconf || die "autoconf failed"
}

src_compile() {
	if use mysql ; then
		myconf="--with-mysql=/usr/$(get_libdir)/mysql/libmysqlclient.a"
	else
		myconf="--without-mysql"
	fi

	econf \
		--enable-shared \
		--enable-static \
		--with-zlib \
		--with-md5 \
		--with-expat \
		$(use_with ssl) \
		${myconf} || die

	emake check-am || die
	use ppc-macos && echo "#undef HAVE_APPKIT_APPKIT_H" >> wwwconf.h
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog
	dohtml -r .
}
