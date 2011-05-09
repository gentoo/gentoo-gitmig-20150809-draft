# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/suacomp/suacomp-0.6.7.ebuild,v 1.1 2011/05/09 08:30:52 mduft Exp $

EAPI=3

inherit toolchain-funcs

DESCRIPTION="library wrapping the interix lib-c to make it less buggy."
HOMEPAGE="http://suacomp.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BEER-WARE"
SLOT="0"
KEYWORDS="-* ~x86-interix"
IUSE=""

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

src_compile() {
	local mycflags=
	[[ ${CHOST} == *-interix3* ]] && mycflags="-DINTERIX3"

	emake all CC=$(tc-getCC) CFLAGS="${CFLAGS} ${mycflags}" $(get_opts) || die "emake failed"
}

src_install() {
	emake install PREFIX="${EPREFIX}/usr" DESTDIR="${D}" $(get_opts) || die "emake install failed"
}

src_test() {
	emake check $(get_opts) || die "emake check failed"
}
