# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/git/git-4.3.20.ebuild,v 1.16 2009/04/10 04:44:46 darkside Exp $

DESCRIPTION="GNU Interactive Tools - increase speed and efficiency of most daily task"
HOMEPAGE="http://www.gnu.org/software/git/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc"
IUSE=""

DEPEND="sys-devel/binutils
	!dev-util/git
	!dev-util/cogito"

src_install() {
	sed -i -e 's:/doc:/share/doc:' doc/Makefile || die "sed failed"
	einstall || die
	dodoc AUTHORS INSTALL README NEWS
}
