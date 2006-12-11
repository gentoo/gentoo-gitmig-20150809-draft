# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pstack/pstack-1.1.ebuild,v 1.5 2006/12/11 07:36:38 beu Exp $

DESCRIPTION="Display stack trace of a running process."
SRC_URI="http://www.whatsis.com/pstack/${PN}.tgz"
HOMEPAGE="http://www.whatsis.com/pstack/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -alpha"
IUSE=""

S=${WORKDIR}/${PN}

src_compile() {
	make || die
}

src_install() {
	dosbin pstack
	doman man1/pstack.1
}
