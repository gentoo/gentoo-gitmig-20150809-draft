# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/autobook/autobook-1.3.ebuild,v 1.2 2003/06/29 17:33:11 aliz Exp $

DESCRIPTION="GNU Autoconf, Automake and Libtool"
HOMEPAGE="http://sources.redhat.com/autobook/"
SRC_URI="http://sources.redhat.com/autobook/${P}.tar.gz"
LICENSE="OPL"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=""
#RDEPEND=""

src_install() {
	dohtml *
}

