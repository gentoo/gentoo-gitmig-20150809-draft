# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ippl/ippl-1.4.14.ebuild,v 1.4 2003/09/05 23:40:09 msterret Exp $

DESCRIPTION="A daemon which logs TCP/UDP/ICMP packets"
HOMEPAGE="http://pltplp.net/ippl/"
SRC_URI="http://pltplp.net/ippl/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=yacc-1.9.1-r1 >=flex-2.5.4a-r4"
RDEPEND=""

S=${WORKDIR}/${P}

src_install() {
	dosbin Source/ippl

	insinto "/etc"
	doins ippl.conf

	doman Docs/ippl.8 Docs/ippl.conf.5

	dodoc BUGS CREDITS HISTORY README TODO
	newdoc ippl.conf ippl.conf-sample

	exeinto "/etc/init.d"
	newexe ${FILESDIR}/ippl.rc ippl
}
