# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/deltarpm/deltarpm-3.4.ebuild,v 1.1 2008/06/09 00:36:56 darkside Exp $

inherit eutils

DESCRIPTION="tools to create and apply deltarpms"
HOMEPAGE="ftp://ftp.suse.com/pub/projects/deltarpm/"
SRC_URI="ftp://ftp.suse.com/pub/projects/deltarpm/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/bzip2
	<app-arch/rpm-5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^prefix/s:/local::' \
		-e '/^mandir/s:/man:/share/man:' \
		Makefile || die
}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README
}
