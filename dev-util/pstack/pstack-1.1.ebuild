# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pstack/pstack-1.1.ebuild,v 1.6 2007/10/06 16:18:42 coldwind Exp $

DESCRIPTION="Display stack trace of a running process."
SRC_URI="mirror://gentoo/${PN}.tgz"
HOMEPAGE="http://www.linuxcommand.org/man_pages/pstack1.html"
# Old upstream HOMEPAGE: www.whatsis.com/pastack is dead, using
# the man page at the moment.

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 -ppc -sparc -alpha"
IUSE=""

S=${WORKDIR}/${PN}

src_install() {
	dosbin pstack || die "dosbin failed"
	doman man1/pstack.1
}
