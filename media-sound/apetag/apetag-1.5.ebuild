# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/apetag/apetag-1.5.ebuild,v 1.2 2004/10/07 08:50:56 eradicator Exp $

IUSE=""

inherit eutils

S=${WORKDIR}/Apetag

DESCRIPTION="Command-line ape 2.0 tagger"
HOMEPAGE="http://muth.org/Robert/Apetag/"
SRC_URI="http://muth.org/Robert/Apetag/${PN}.${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=""
RDEPEND="dev-lang/python"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	sed -ie "s:-e Artist= -e:-p Artist= -p:" main.C || die
}

src_compile() {
	emake CXXDEBUG="" CXXOPT="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	dobin apetag || die
	dobin tagdir.py || die
	dodoc 00changes 00copying 00readme || die
}
