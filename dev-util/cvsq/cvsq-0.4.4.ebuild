# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsq/cvsq-0.4.4.ebuild,v 1.2 2004/06/03 15:43:46 dholm Exp $

IUSE=""

DESCRIPTION="cvsq is a tool that enables developers with a dial-up connection to work comfortably with CVS by queueing the commits."
SRC_URI="http://metawire.org/~vslavik/sw/cvsq/download/${P}.tar.gz"
HOMEPAGE="http://metawire.org/~vslavik/sw/cvsq/"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~x86 ~ppc"

DEPEND=""		# This is just a shell script.
RDEPEND="dev-util/cvs
		app-shells/bash
		sys-apps/coreutils"

S="${WORKDIR}/${P}"

src_install () {
	sed -i -e "s:tail -n 1: tail -1:g" cvsq
	dodir /usr/bin
	dobin cvsq
	dodoc README AUTHORS ChangeLog
}
