# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/delta/delta-20050913.ebuild,v 1.8 2006/07/12 14:27:33 vapier Exp $

MY_PV="${PV:0:4}.${PV:4:2}.${PV:6:2}"
DESCRIPTION="Heuristically minimizes interesting files"
HOMEPAGE="http://delta.tigris.org/"
SRC_URI="http://delta.tigris.org/files/documents/3103/25616/${PN}-${MY_PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh x86"
IUSE=""

DEPEND="dev-lang/perl"

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin delta multidelta topformflat || die
	dodoc Readme
}
