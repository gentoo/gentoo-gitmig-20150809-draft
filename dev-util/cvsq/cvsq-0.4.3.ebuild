# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsq/cvsq-0.4.3.ebuild,v 1.6 2004/08/07 22:31:45 slarti Exp $

IUSE=""

DESCRIPTION="cvsq is a tool that enables developers with a dial-up connection to work comfortably with CVS by queuing the commits."
SRC_URI="http://www.volny.cz/v.slavik/lt/download/${P}.tar.gz"
HOMEPAGE="http://www.volny.cz/v.slavik/lt/cvsq.html"

SLOT="0"
LICENSE="public-domain"
KEYWORDS="x86"

DEPEND=""		# This is just a shell script.
RDEPEND="dev-util/cvs
		app-shells/bash
		sys-apps/coreutils"

src_install () {
	dodir /usr/bin
	dobin cvsq
	dodoc README AUTHORS ChangeLog
}
