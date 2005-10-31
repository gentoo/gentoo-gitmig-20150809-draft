# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/apetag/apetag-1.7.ebuild,v 1.1 2005/10/31 17:14:52 flameeyes Exp $

IUSE=""

inherit eutils toolchain-funcs

S="${WORKDIR}/Apetag"

DESCRIPTION="Command-line ape 2.0 tagger"
HOMEPAGE="http://muth.org/Robert/Apetag/"
SRC_URI="http://muth.org/Robert/Apetag/${PN}.${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=""
RDEPEND="dev-lang/python"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:-e Artist= -e:-p Artist= -p:" main.C || die
}

src_compile() {
	emake CXX="$(tc-getCXX)" CXXDEBUG="" CXXOPT="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dobin apetag || die
	dobin tagdir.py || die
	dodoc 00changes 00readme || die
}
