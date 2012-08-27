# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/ssh-multiadd/ssh-multiadd-1.3.1.ebuild,v 1.26 2012/08/27 18:00:02 armin76 Exp $

inherit eutils

DESCRIPTION="adds multiple ssh keys to the ssh authentication agent"
HOMEPAGE="http://www.azstarnet.com/~donut/programs/index_s.html#ssh-multiadd"
SRC_URI="http://www.azstarnet.com/~donut/programs/ssh-multiadd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="X"

DEPEND=">=dev-lang/python-2.0-r3
	X? ( >=net-misc/x11-ssh-askpass-1.2.2 )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}.diff
}

src_install() {
	dobin ssh-multiadd || die
	doman ssh-multiadd.1
	dodoc ChangeLog README todo
}
