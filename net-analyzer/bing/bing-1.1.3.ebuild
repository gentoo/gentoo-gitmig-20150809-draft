# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/bing/bing-1.1.3.ebuild,v 1.3 2003/09/07 07:12:08 msterret Exp $

DESCRIPTION="A point-to-point bandwidth measurement tool."
SRC_URI="http://distro.ibiblio.org/pub/Linux/distributions/debian/pool/main/b/bing/${PN}_${PV}.orig.tar.gz"
HOMEPAGE="http://www.cnam.fr/reseau/bing.html"

KEYWORDS="~x86 ~sparc"
SLOT="0"
LICENSE="as-is"
IUSE=""

RDEPEND="virtual/glibc"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i \
		-e "s:#COPTIM = -g: COPTIM = ${CFLAGS}:" Makefile || \
			die "sed Makefile failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin bing
	doman unix/bing.8
	dodoc ChangeLog Readme.{1st,txt}
}
