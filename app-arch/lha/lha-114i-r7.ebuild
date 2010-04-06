# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/lha/lha-114i-r7.ebuild,v 1.9 2010/04/06 05:46:49 abcd Exp $

EAPI="3"

inherit eutils autotools

MY_P="${PN}-1.14i-ac20050924p1"

DESCRIPTION="Utility for creating and opening lzh archives"
HOMEPAGE="http://lha.sourceforge.jp"
SRC_URI="mirror://sourceforge.jp/${PN}/22231/${MY_P}.tar.gz"

LICENSE="lha"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~m68k-mint"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-file-list-from-stdin.patch
	eautoreconf
}

src_configure() {
	if [[ ${CHOST} == *-interix* ]]; then
		export ac_cv_header_inttypes_h=no
		export ac_cv_func_iconv=no
	fi
	econf
}

src_install() {
	emake DESTDIR="${D}" \
		mandir="${EPREFIX}"/usr/share/man/ja \
		install || die "emake failed."
	dodoc ChangeLog Hacking_of_LHa
}
