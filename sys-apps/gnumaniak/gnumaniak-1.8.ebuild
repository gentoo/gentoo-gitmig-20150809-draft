# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gnumaniak/gnumaniak-1.8.ebuild,v 1.7 2004/06/11 13:04:21 kloeri Exp $

MY_PN=${PN/-/}
S=${WORKDIR}/${P}
DESCRIPTION="Up to date man pages for various GNU utils section 1"
SRC_URI="http://www.linalco.com/ragnar/${P}.tar.gz"
HOMEPAGE="http://www.linalco.com/ragnar/"

SLOT="0"
LICENSE="LDP"
KEYWORDS="x86 amd64 ~ppc ~sparc alpha"

RDEPEND="sys-apps/man"

src_install() {
	for x in `find * -type d -not -name ongoing`
	do
		doman $x/*.[1-9]
	done
	dodoc LICENSE README gnumaniak-1.8.lsm
}
