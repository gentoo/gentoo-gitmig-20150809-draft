# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-3.4.1.ebuild,v 1.11 2004/10/23 08:11:43 mr_bones_ Exp $

MY_PN=${PN}src
DESCRIPTION="Uncompress rar files"
HOMEPAGE="http://www.rarlab.com/rar_add.htm"
SRC_URI="http://www.rarlab.com/rar/${MY_PN}-${PV}.tar.gz"

LICENSE="unRAR"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~hppa amd64 ppc64 ppc-macos"
IUSE=""

DEPEND=""

S="${WORKDIR}/unrar"

src_compile() {
	emake -f makefile.unix CXXFLAGS="$CXXFLAGS" || die "emake failed"
}

src_install() {
	dobin unrar || die "dobin failed"
	dodoc readme.txt
}
