# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/apetag/apetag-1.12.ebuild,v 1.1 2009/04/30 21:39:05 patrick Exp $

inherit eutils toolchain-funcs base

DESCRIPTION="Command-line ape 2.0 tagger"
HOMEPAGE="http://muth.org/Robert/Apetag/"
SRC_URI="http://muth.org/Robert/Apetag/${PN}.${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/python"

S=${WORKDIR}/Apetag

src_unpack() {
	base_src_unpack
	sed -i \
		-e 's,CXXDEBUG,LDFLAGS,g' \
		"${S}"/Makefile \
		|| die "404. Makefile not found."
}

src_compile() {
	emake CXX="$(tc-getCXX)" LDFLAGS="${LDFLAGS}" CXXOPT="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dobin apetag || die
	dobin tagdir.py rmid3tag.py cddb.py || die
	dodoc 00readme || die
}
