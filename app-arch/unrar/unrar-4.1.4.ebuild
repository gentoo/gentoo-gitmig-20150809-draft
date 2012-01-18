# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/unrar/unrar-4.1.4.ebuild,v 1.1 2012/01/18 10:10:51 ssuominen Exp $

EAPI=4
inherit flag-o-matic toolchain-funcs

MY_PN=${PN}src

DESCRIPTION="Uncompress rar files"
HOMEPAGE="http://www.rarlab.com/rar_add.htm"
SRC_URI="http://www.rarlab.com/rar/${MY_PN}-${PV}.tar.gz"

LICENSE="unRAR"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="!<=app-arch/unrar-gpl-0.0.1_p20080417"

S=${WORKDIR}/unrar

src_compile() {
	append-lfs-flags #356155
	emake \
		-f makefile.unix \
		CXXFLAGS="${CXXFLAGS}" \
		CXX="$(tc-getCXX)" \
		STRIP="true"
}

src_install() {
	dobin unrar
	dodoc readme.txt
}
