# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/suacomp/suacomp-0.6.9.ebuild,v 1.1 2011/05/23 14:54:47 mduft Exp $

EAPI=3

inherit toolchain-funcs flag-o-matic

DESCRIPTION="library wrapping the interix lib-c to make it less buggy."
HOMEPAGE="http://suacomp.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BEER-WARE"
SLOT="0"
KEYWORDS="-* ~x86-interix"
IUSE="debug"

DEPEND=""
RDEPEND=""

get_opts() {
	local shlibc=
	local stlibc=

	for dir in /usr/lib /usr/lib/x86; do
		[[ -f ${dir}/libc.a ]] && stlibc=${dir}/libc.a

		for name in libc.so.5.2 libc.so.3.5; do
			[[ -f ${dir}/${name} ]] && { shlibc=${dir}/${name}; break; }
		done

		[[ -f ${shlibc} && -f ${stlibc} ]] && break
	done

	echo "SHARED_LIBC=${shlibc} STATIC_LIBC=${stlibc}"
}

pkg_setup() {
	if use debug; then
		append-flags -D_DEBUG -D_DEBUG_TRACE
	fi

	[[ ${CHOST} == *-interix3* ]] && append-flags -DINTERIX3
	[[ ${CHOST} == *-interix5* ]] && append-flags -DINTERIX5
}

src_compile() {
	emake all CC=$(tc-getCC) $(get_opts) CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake install PREFIX="${EPREFIX}/usr" DESTDIR="${D}" $(get_opts) \
		CFLAGS="${CFLAGS}" || die "emake install failed"
}

src_test() {
	local v=

	use debug && v="TEST_VERBOSE=1"
	use debug && export SUACOMP_DEBUG_OUT=stderr

	emake check $(get_opts) ${v} || die "emake check failed"
}
