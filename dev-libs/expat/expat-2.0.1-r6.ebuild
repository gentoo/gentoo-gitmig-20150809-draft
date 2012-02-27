# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/expat/expat-2.0.1-r6.ebuild,v 1.3 2012/02/27 15:17:31 ago Exp $

EAPI=4
inherit eutils libtool toolchain-funcs

DESCRIPTION="XML parsing libraries"
HOMEPAGE="http://expat.sourceforge.net/"
SRC_URI="mirror://sourceforge/expat/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="elibc_FreeBSD examples static-libs unicode"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-check_stopped_parser.patch \
		"${FILESDIR}"/${P}-fix_bug_1990430.patch \
		"${FILESDIR}"/${P}-CVE-2009-3560-revised.patch

	elibtoolize
	epunt_cxx

	mkdir "${S}"-build{,u,w} || die
}

src_configure() {
	local myconf="$(use_enable static-libs static)"

	pushd "${S}"-build >/dev/null
	ECONF_SOURCE="${S}" econf ${myconf}
	popd >/dev/null

	if use unicode; then
		pushd "${S}"-buildu >/dev/null
		CPPFLAGS+=" -DXML_UNICODE" ECONF_SOURCE="${S}" econf ${myconf}
		popd >/dev/null

		pushd "${S}"-buildw >/dev/null
		CFLAGS+=" -fshort-wchar" CPPFLAGS+=" -DXML_UNICODE_WCHAR_T" ECONF_SOURCE="${S}" econf ${myconf}
		popd >/dev/null
	fi
}

src_compile() {
	pushd "${S}"-build >/dev/null
	emake
	popd >/dev/null

	if use unicode; then
		pushd "${S}"-buildu >/dev/null
		emake buildlib LIBRARY=libexpatu.la
		popd >/dev/null

		pushd "${S}"-buildw >/dev/null
		emake buildlib LIBRARY=libexpatw.la
		popd >/dev/null
	fi
}

src_install() {
	dodoc Changes README
	dohtml doc/*

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins examples/*.c
	fi

	pushd "${S}"-build >/dev/null
	emake install DESTDIR="${D}"
	popd >/dev/null

	if use unicode; then
		pushd "${S}"-buildu >/dev/null
		emake installlib DESTDIR="${D}" LIBRARY=libexpatu.la
		popd >/dev/null

		pushd "${S}"-buildw >/dev/null
		emake installlib DESTDIR="${D}" LIBRARY=libexpatw.la
		popd >/dev/null
	fi

	use static-libs || rm -f "${ED}"usr/lib*/libexpat{,u,w}.la

	# libgeom in /lib and ifconfig in /sbin require it on FreeBSD since we
	# stripped the libbsdxml copy starting from freebsd-lib-8.2-r1
	use elibc_FreeBSD && gen_usr_ldscript -a expat{,u,w}
}
