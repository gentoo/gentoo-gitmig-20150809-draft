# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mingw-runtime/mingw-runtime-3.10.ebuild,v 1.3 2006/09/24 14:11:15 vapier Exp $

# This version does not work as the configure script expects the installed
# cross-compiler to be able to link binaries ... except we haven't provided
# any of the crt objects yet so it is impossible to link binaries.
# Older mingw-runtime packages hacked around the issue, but this version seems
# to have dropped said hack thus breaking the package.

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

inherit eutils flag-o-matic

DESCRIPTION="Free Win32 runtime and import library definitions"
HOMEPAGE="http://www.mingw.org/"
SRC_URI="mirror://sourceforge/mingw/${P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-*"
IUSE=""
RESTRICT="strip"

DEPEND=""

just_headers() {
	use crosscompile_opts_headers-only && [[ ${CHOST} != ${CTARGET} ]]
}

pkg_setup() {
	if [[ ${CBUILD} == ${CHOST} ]] && [[ ${CHOST} == ${CTARGET} ]] ; then
		die "Invalid configuration"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/W32API_INCLUDE/s:=.*:='-I /usr/${CTARGET}/usr/include':" \
		$(find -name configure) || die
	epatch "${FILESDIR}"/${PN}-3.9-DESTDIR.patch
}

src_compile() {
	just_headers && return 0

	strip-unsupported-flags
	econf \
		--host=${CTARGET} \
		--prefix=/usr/${CTARGET} \
		|| die
	emake || die
}

src_install() {
	if just_headers ; then
		insinto /usr/${CTARGET}/usr/include
		doins -r include/* || die
	else
		emake install DESTDIR="${D}" || die
		env -uRESTRICT CHOST=${CTARGET} prepallstrip
		rm -rf "${D}"/usr/${CTARGET}/doc
		dodoc CONTRIBUTORS ChangeLog README TODO readme.txt
	fi
	dosym usr/include /usr/${CTARGET}/sys-include
}
