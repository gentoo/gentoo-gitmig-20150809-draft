# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/bsdsfv/bsdsfv-1.14.ebuild,v 1.3 2003/06/29 15:40:50 aliz Exp $

S="${WORKDIR}/bsdsfv"
DESCRIPTION="BSDSFV: All-in-one SFV checksum utility"
SRC_URI="mirror://sourceforge/bsdsfv/${PN}.${PV}.tar.gz"
HOMEPAGE="http://bsdsfv.sourceforge.net/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc ~sparc "

DEPEND="virtual/glibc"

src_compile() {
	cd ${S}
	epatch ${FILESDIR}/${PN}-${PV}-gentoo.diff
	emake || die
}

src_install() {
	dobin bsdsfv
	dodoc README MANUAL
}
