# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libwww/libwww-5.4.0-r8.ebuild,v 1.1 2012/08/06 03:02:18 ottxor Exp $

EAPI=4

inherit eutils multilib autotools

PATCHVER="1.3"
MY_P=w3c-${P}

DESCRIPTION="A general-purpose client side WEB API"
HOMEPAGE="http://www.w3.org/Library/"
SRC_URI="http://www.w3.org/Library/Distribution/${MY_P}.tgz
	mirror://gentoo/${P}-patches-${PATCHVER}.tar.bz2"

LICENSE="W3C"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~ppc-aix ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE="mysql ssl"

RDEPEND=">=sys-libs/zlib-1.1.4
	mysql? ( virtual/mysql )
	ssl? ( >=dev-libs/openssl-0.9.6 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-lang/perl"

S=${WORKDIR}/${MY_P}

src_prepare() {
	rm -f configure.in
	EPATCH_SUFFIX="patch" epatch "${WORKDIR}"/patch
	eautoreconf
}

src_configure() {
	if use mysql; then
		myconf="--with-mysql=${EPREFIX}/usr/$(get_libdir)/mysql/libmysqlclient.a"
	else
		myconf="--without-mysql"
	fi

	export ac_cv_header_appkit_appkit_h=no
	econf \
		--enable-shared \
		--enable-static \
		--with-zlib \
		--with-md5 \
		--with-expat \
		$(use_with ssl) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc ChangeLog
	dohtml -r .
}
