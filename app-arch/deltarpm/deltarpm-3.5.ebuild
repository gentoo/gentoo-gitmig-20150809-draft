# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/deltarpm/deltarpm-3.5.ebuild,v 1.1 2010/05/18 08:58:16 jlec Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="tools to create and apply deltarpms"
HOMEPAGE="ftp://ftp.suse.com/pub/projects/deltarpm/"
SRC_URI="ftp://ftp.suse.com/pub/projects/deltarpm/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	sys-libs/zlib
	app-arch/xz-utils
	app-arch/bzip2
	<app-arch/rpm-5"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-zlib.patch
	sed -i \
		-e '/^prefix/s:/local::' \
		-e '/^mandir/s:/man:/share/man:' \
		Makefile || die
}

src_compile() {
	emake \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		CC="$(tc-getCC)" || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README
}
