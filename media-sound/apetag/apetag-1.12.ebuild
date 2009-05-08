# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/apetag/apetag-1.12.ebuild,v 1.3 2009/05/08 18:23:31 ssuominen Exp $

EAPI=2
inherit toolchain-funcs

DESCRIPTION="Command-line ape 2.0 tagger"
HOMEPAGE="http://muth.org/Robert/Apetag/"
SRC_URI="http://muth.org/Robert/Apetag/${PN}.${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python"
DEPEND=""

S=${WORKDIR}/Apetag

src_prepare() {
	sed -i -e 's:CXXDEBUG:LDFLAGS:g' \
		"${S}"/Makefile || die "sed failed"
}

src_compile() {
	tc-export CXX
	emake CXXFLAGS="${CXXFLAGS} -pedantic" \
		LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin apetag tagdir.py rmid3tag.py cddb.py || die "dobin failed"
	dodoc 00readme
}
