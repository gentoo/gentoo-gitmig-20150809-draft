# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mingw64-runtime/mingw64-runtime-20090419.ebuild,v 1.1 2009/12/09 22:42:36 vapier Exp $

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

inherit eutils flag-o-matic

DESCRIPTION="Free Win64 runtime and import library definitions"
HOMEPAGE="http://mingw-w64.sourceforge.net/"
SRC_URI="mirror://sourceforge/mingw-w64/mingw-w64-snapshot-${PV}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="crosscompile_opts_headers-only"
RESTRICT="strip"

S=${WORKDIR}/trunk/mingw-w64-crt

is_crosscompile() {
	[[ ${CHOST} != ${CTARGET} ]]
}
just_headers() {
	use crosscompile_opts_headers-only && [[ ${CHOST} != ${CTARGET} ]]
}

pkg_setup() {
	if [[ ${CBUILD} == ${CHOST} ]] && [[ ${CHOST} == ${CTARGET} ]] ; then
		die "Invalid configuration"
	fi
}

src_compile() {
	just_headers && return 0

	CHOST=${CTARGET} strip-unsupported-flags
	econf --host=${CTARGET} || die
	emake || die
}

src_install() {
	insinto /usr/${CTARGET}/usr/include
	doins -r ../mingw-w64-headers/{,*/}include/* || die
	is_crosscompile \
		&& dosym usr /usr/${CTARGET}/mingw \
		&& dosym usr/include /usr/${CTARGET}/sys-include
	just_headers && return 0

	local insdir
	emake install DESTDIR="${D}" || die
	env -uRESTRICT CHOST=${CTARGET} prepallstrip
	rm -rf "${D}"/usr/doc
	dodoc ChangeLog
}
