# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/splint/splint-3.0.1.6.ebuild,v 1.4 2003/09/06 20:32:23 msterret Exp $

DESCRIPTION="Check C programs for vulnerabilities and programming mistakes"
HOMEPAGE="http://lclint.cs.virginia.edu/"
SRC_URI="http://www.splint.org/downloads/${P}.src.tgz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""
DEPEND="sys-devel/gcc"

src_install() {
	make DESTDIR=${D} install || die
	dobin ${S}/splint
	doman ${S}/doc/*.1
}
