# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsq/cvsq-0.4.3.ebuild,v 1.3 2004/03/13 01:49:46 mr_bones_ Exp $

IUSE=""

DESCRIPTION="cvsq is a tool that enables developers with a dial-up connection to work comfortably with CVS by queueing the commits."
SRC_URI="http://www.volny.cz/v.slavik/lt/download/${P}.tar.gz"
HOMEPAGE="http://www.volny.cz/v.slavik/lt/cvsq.html"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="~x86"

DEPEND=""		# This is just a shell script.
RDEPEND="dev-util/cvs
		app-shells/bash
		sys-apps/coreutils"

src_install () {
	dodir /usr/bin
	dobin cvsq
	dodoc README AUTHORS ChangeLog
}
