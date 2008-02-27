# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/splint/splint-3.1.2.ebuild,v 1.10 2008/02/27 11:11:01 coldwind Exp $

DESCRIPTION="Check C programs for vulnerabilities and programming mistakes"
HOMEPAGE="http://lclint.cs.virginia.edu/"
SRC_URI="http://www.splint.org/downloads/${P}.src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86"
IUSE=""

DEPEND=""

src_compile() {
	econf || die
	emake -j1 || die "emake failed"
}

src_install() {
	make -j1 DESTDIR="${D}" install || die
}
