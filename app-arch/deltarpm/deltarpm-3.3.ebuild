# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/deltarpm/deltarpm-3.3.ebuild,v 1.2 2007/08/10 17:04:08 gregkh Exp $

inherit eutils

DESCRIPTION="tools to create and apply deltarpms"
HOMEPAGE="ftp://ftp.suse.com/pub/projects/deltarpm/"
SRC_URI="mirror://opensuse/tools/drpmsync/src/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/bzip2
	app-arch/rpm"

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
