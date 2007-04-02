# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/w32api/w32api-3.9.ebuild,v 1.1 2007/04/02 23:18:09 vapier Exp $

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
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
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
	epatch "${FILESDIR}"/${PN}-3.7-DESTDIR.patch
}

src_compile() {
	just_headers && return 0

	CHOST=${CTARGET} strip-unsupported-flags
	econf \
		--host=${CTARGET} \
		--prefix=/usr/${CTARGET}/usr \
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
		dodoc CONTRIBUTIONS ChangeLog README.w32api TODO
	fi
}
