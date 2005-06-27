# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/rman/rman-3.1.ebuild,v 1.8 2005/06/27 18:57:47 j4rg0n Exp $

inherit eutils

DESCRIPTION="PolyGlotMan man page translator AKA RosettaMan"
HOMEPAGE="http://polyglotman.sourceforge.net/"
SRC_URI="mirror://sourceforge/polyglotman/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="ppc ~ppc-macos sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	epatch ${FILESDIR}/${PF}-gentoo.diff || die "patch failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS} -finline-functions" || die "make failed"
}

src_install() {
	dobin ${PN} || die
	doman ${PN}.1
}
