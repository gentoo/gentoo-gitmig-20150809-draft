# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/splint/splint-3.1.1.ebuild,v 1.6 2004/06/25 02:47:30 agriffis Exp $

DESCRIPTION="Check C programs for vulnerabilities and programming mistakes"
HOMEPAGE="http://lclint.cs.virginia.edu/"
SRC_URI="http://www.splint.org/downloads/${P}.src.tgz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~amd64"
IUSE=""
DEPEND="sys-devel/gcc"
MAKEOPTS="-j1"

src_install() {
	make DESTDIR=${D} install || die
	dobin ${S}/splint
	doman ${S}/doc/*.1
}
