# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gnumaniak/gnumaniak-1.8.ebuild,v 1.13 2006/06/21 17:31:07 vapier Exp $

MY_PN=${PN/-/}
DESCRIPTION="Up to date man pages for various GNU utils section 1"
SRC_URI="http://www.linalco.com/ragnar/${P}.tar.gz"
HOMEPAGE="http://www.linalco.com/ragnar/"

LICENSE="LDP"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="virtual/man"

src_install() {
	local x
	for x in $(find . -type d -not -name ongoing) ; do
		doman $x/*.[1-9] || die
	done
	dodoc README gnumaniak-1.8.lsm
}
