# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/git/git-4.3.20.ebuild,v 1.1 2002/10/25 18:30:46 vapier Exp $

DESCRIPTION="GNU Interactive Tools - increase speed and efficiency of most daily task"
HOMEPAGE="http://www.gnu.org/software/git/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND="sys-devel/binutils"

src_compile() {
	econf
	emake
}

src_install() {
	einstall
	dodoc AUTHORS COPYING INSTALL README NEWS VERSION STATUS
}
