# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-3.6.2.ebuild,v 1.10 2006/07/03 19:32:55 grobian Exp $

inherit toolchain-funcs

MY_PN=${PN}src
DESCRIPTION="Uncompress rar files"
HOMEPAGE="http://www.rarlab.com/rar_add.htm"
SRC_URI="http://www.rarlab.com/rar/${MY_PN}-${PV}.tar.gz"

LICENSE="unRAR"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc-macos ppc64 sparc x86"
IUSE=""

DEPEND="!app-arch/unrar-gpl"

S=${WORKDIR}/unrar

src_compile() {
	emake \
		-f makefile.unix \
		CXXFLAGS="${CXXFLAGS}" \
		CXX="$(tc-getCXX)" \
		STRIP="true" || die "emake failed"
}

src_install() {
	dobin unrar || die "dobin failed"
	dodoc readme.txt
}
