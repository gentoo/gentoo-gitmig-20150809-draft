# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/crwinfo/crwinfo-0.2.ebuild,v 1.1 2005/01/27 00:28:45 swtaylor Exp $

DESCRIPTION="Canon raw image (CRW) information and thumbnail extractor"
HOMEPAGE="http://freshmeat.net/projects/crwinfo/"
SRC_URI="http://neuemuenze.heim1.tu-clausthal.de/~sven/crwinfo/CRWInfo-${PV}.tar.gz"
S="${WORKDIR}/CRWInfo-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64 alpha ia64 hppa ppc64"
IUSE=""

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A} ; cd ${S}
	patch -p0 < ${FILESDIR}/${P}.patch
}

src_compile() {
	emake || die
}

src_install() {
	dobin crwinfo || die
	dodoc README spec
}
